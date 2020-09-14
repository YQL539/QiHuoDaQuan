//
//  NSObject+Model.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/4.
//  Copyright © 2020 Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Model)
///value是正常的非集合（字典和数组）类型的参数
+ (instancetype)ModelWithStringDict:(NSDictionary *)dict;
///model转化为字典
+ (NSDictionary *)dicFromObject:(NSObject *)object;
 ///通过单例模式对工具类进行初始化
+ (void)configInfo:(NSDictionary *)infoDic withManage:(NSObject *)manager;
@end

NS_ASSUME_NONNULL_END
