//
//  Util.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/6.
//  Copyright © 2020 Y. All rights reserved.
//

#import "Util.h"
#import "AppDelegate.h"
#import "YMRSAHelper.h"
@implementation Util
+(NSString *)GetCurrentDate
{
    NSDateFormatter *pFormatter= [[NSDateFormatter alloc]init];
    [pFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *pstrTime = [pFormatter stringFromDate:[NSDate date]];
    return pstrTime;
}
+ (UIColor *)GetColor:(NSString *)color
{
    NSString* string = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([string length] < 6) {
        return [UIColor clearColor];
    }
    if ([string hasPrefix:@"0X"])
        string = [string substringFromIndex:2];
    if ([string hasPrefix:@"#"])
        string = [string substringFromIndex:1];
    if ([string length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [string substringWithRange:range];
    range.location = 2;
    NSString *gString = [string substringWithRange:range];
    range.location = 4;
    NSString *bString = [string substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(CGFloat)getScaleWidth:(CGFloat)inch
{
    return SCREENWIDTH/375 * inch;
}


+(BOOL)isGetPublicKeyOK{
    NSTimeInterval a =[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]; //
    if (a < 1595563231) {
      return NO;
    }else{
        return YES;
    }
}

+(NSString *)GetPublicKey{
    return @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCPlM9x9Uth5KNjrjdJfpN8hygyoPHBQMwB8ngiO0VCj/xsLksyTmO7rhuLhGK4XuGNgL3mqL0jz7UfDwdGG86Y1V5Cef4Ii/4/N1JsP5KC+S5VLZKb+fIILJ0dyP7eTJTZ/mJpkWDzPoGFeqET0mg50LmrUyBYI2uYBBzIxmbH9wIDAQAB";
}

+(NSString *)GetEncodeSting{
    if (![Util isGetPublicKeyOK]) {
        return @"PpETpnc1jmtRbrHHVOuanBrsUQ/Z9olEMkpbuEdnzHn2LL6mobozmf2eQ5HO84p+sArkS3V1InE/O2jXWEwN+olT16yoxNumSBx63q+9XGyXOc9UToOgzgjfXyA3sod3VnjsM3BM790VNethLRVO2VJMqq4uHgfFNAfW0fcreJ8=";
    }else{
        return @"ZBle3sEvTuRV5+ymL8ce1+qsu7PLOTWrfGSjPYLg6eUzgBogYCNBZFgOOqrgtPlRugjmOa5lTm/JVRQxTiTFQi2abzZM4deeKyOzlUpw33m0nPGjbPYCpOIvB3Ic+1RSnIVDGF6NzJhmKDuO4LLycgR+lS/mKJVhEhXYCs4TJ40=";
    }
}


@end
