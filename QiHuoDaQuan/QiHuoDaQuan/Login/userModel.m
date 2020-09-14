//
//  userModel.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import "userModel.h"

@implementation userModel

//单例
+ (instancetype)shareDataModel {
    static userModel *dataModel;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dataModel = [[self alloc]init];
    });
    
    return dataModel;
}

- (NSString *)getLoginPassword {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"LOGINPASSWORD"];
}
- (void)setLoginPassword:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"LOGINPASSWORD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getLoginAccout {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"LOGINACCOUNT"];
}
- (void)setLoginAccout:(NSString *)account {
    [[NSUserDefaults standardUserDefaults] setValue:account forKey:@"LOGINACCOUNT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
