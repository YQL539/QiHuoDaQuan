//
//  NSObject+Model.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/4.
//  Copyright © 2020 Y. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
@implementation NSObject (Model)

+ (instancetype)ModelWithStringDict:(NSDictionary *)dict {
    NSObject * obj = [[self alloc]init];
    [obj transformStringDict:dict];
    return obj;
}

- (void)transformStringDict:(NSDictionary *)dict {
    Class cla = self.class;
    // count:成员变量个数
    unsigned int outCount = 0;
    // 获取成员变量数组
    Ivar *ivars = class_copyIvarList(cla, &outCount);
    // 遍历所有成员变量
    for (int i = 0; i < outCount; i++) {
        // 获取成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量名字
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 成员变量名转为属性名（去掉下划线 _ ）
        key = [key substringFromIndex:1];
        // 取出字典的值
        id value = dict[key];
        // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
        if (value == nil) continue;
        // 利用KVC将字典中的值设置到模型上
        [self setValue:value forKeyPath:key];
    }
    //需要释放指针，因为ARC不适用C函数
    free(ivars);
}


#pragma mark-系统方法（此时将方法进行交换）
+ (void)load{
    //将属性的所有setter、getter方法与自定义的方法互换
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        
        Ivar ivar = varList[i];
        //获取属性名称
        const char *attr = ivar_getName(ivar);
        NSString *attriName = [NSString stringWithFormat:@"%s",attr];
        attriName = [attriName substringFromIndex:1];
        NSString *firstAttriName = [attriName substringToIndex:1];
        firstAttriName = [firstAttriName uppercaseString];
        NSString *lastAttriName = [attriName substringFromIndex:1];
        //构造原setter方法
        SEL originalSetSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",firstAttriName,lastAttriName]);
        Method originalSetMethod = class_getInstanceMethod([self class], originalSetSelector);
        //构造原getter方法
        SEL originalGetSelector = NSSelectorFromString(attriName);
        Method originalGetMethod = class_getInstanceMethod([self class], originalGetSelector);
        //新setter方法
        SEL newSetSelector = @selector(setMyAttribute:);
        Method newSetMethod = class_getInstanceMethod([self class], newSetSelector);
        IMP newSetIMP = method_getImplementation(newSetMethod);
        //新getter方法
        SEL newGetSelector = @selector(getAttribute);
        Method newGetMethod = class_getInstanceMethod([self class], newGetSelector);
        IMP newGetIMP = method_getImplementation(newGetMethod);
        //Method Swizzling
        method_setImplementation(originalSetMethod, newSetIMP);
        method_setImplementation(originalGetMethod, newGetIMP);
    }
}

#pragma mark-自定义setter方法（将属性值都存储到用户偏好设置）
- (void)setMyAttribute:(id)attribute{
    //获取调用的方法名称
    NSString *selectorString = NSStringFromSelector(_cmd);
    //对set方法进行属性字段的解析,并存储到用户偏好设置表
    NSString *attr = [selectorString substringFromIndex:3];
    attr = [attr substringToIndex:[attr length]-1];
    //对首字符进行小写
    NSString *firstChar = [attr substringToIndex:1];
    firstChar = [firstChar lowercaseString];
    NSString *lastAttri = [NSString stringWithFormat:@"%@%@",firstChar,[attr substringFromIndex:1]];
    [[NSUserDefaults standardUserDefaults]setObject:attribute forKey:lastAttri];
}

#pragma mark-自定义的getter方法（将属性值从用户偏好设置中取出）
- (id)getAttribute{
    //获取方法名
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:selectorString];
    if ([result isEqual:[NSNull null]]) {
        result = nil;
    }
    return result;
}

#pragma mark-配置数据
+ (void)configInfo:(NSDictionary *)infoDic withManage:(NSObject *)manager{
    NSArray *allKeys = [self getAllProperties];
    for (NSString *key in allKeys) {
        //首字母大写
        NSString *firstKey = [key substringToIndex:1];
        firstKey = [firstKey uppercaseString];
        NSString *lastKey = [key substringFromIndex:1];
        //构造setter方法
        NSString *selectorStr = [NSString stringWithFormat:@"set%@%@:",firstKey,lastKey];
        SEL setSeletor = NSSelectorFromString(selectorStr);
        //调用setter方法
        NSString *value = [infoDic objectForKey:key];
//        NSObject *manager = [self shareDataModel];
        SuppressPerformSelectorLeakWarning(
                                           [manager performSelector:setSeletor withObject:value];
                                           );
    }
}

//获取用户信息类的所有属性
+ (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

//model转化为字典
+ (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        } else if ([value isKindOfClass:[NSArray class]]) {
            //数组或字典
            [dic setObject:[self arrayWithObject:value] forKey:name];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            //数组或字典
            [dic setObject:[self dicWithObject:value] forKey:name];
        } else if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return [dic copy];
}

+ (NSArray *)arrayWithObject:(id)object {
    //数组
    NSMutableArray *array = [NSMutableArray array];
    NSArray *originArr = (NSArray *)object;
    if ([originArr isKindOfClass:[NSArray class]]) {
        for (NSObject *object in originArr) {
            if ([object isKindOfClass:[NSString class]]||[object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]]) {
                //数组或字典
                [array addObject:[self arrayWithObject:object]];
            } else if ([object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self dicWithObject:object]];
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        return [array copy];
    }
    return array.copy;
}

+ (NSDictionary *)dicWithObject:(id)object {
    //字典
    NSDictionary *originDic = (NSDictionary *)object;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([object isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]]||[object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]]) {
                //数组或字典
                [dic setObject:[self arrayWithObject:object] forKey:key];
            } else if ([object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self dicWithObject:object] forKey:key];
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return dic.copy;
}
@end
