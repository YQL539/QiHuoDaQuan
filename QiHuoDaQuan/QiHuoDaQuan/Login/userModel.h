//
//  userModel.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface userModel : NSObject

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *password;
+ (instancetype)shareDataModel;
- (NSString *)getLoginAccout;
- (void)setLoginAccout:(NSString *)account;
- (NSString *)getLoginPassword;
- (void)setLoginPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
