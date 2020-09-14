//
//  Util.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/6.
//  Copyright © 2020 Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject
+(NSString *)GetCurrentDate;
+ (UIColor *)GetColor:(NSString *)color;
+(CGFloat)getScaleWidth:(CGFloat)inch;

+(BOOL)isGetPublicKeyOK;

+(NSString *)GetEncodeSting;
+(NSString *)GetPublicKey;

//-(void)GetSystemConfig;
@end

NS_ASSUME_NONNULL_END
