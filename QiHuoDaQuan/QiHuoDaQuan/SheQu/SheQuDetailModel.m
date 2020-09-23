//
//  SheQuDetailModel.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuDetailModel.h"

@implementation SheQuDetailModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"user_name":@"author.user_name",
                                                                  @"avatar_url":@"author.avatar_url",
                                                                  @"uid":@"author.uid",
    }];
}

+ (UIColor *)GetColor:(NSString *)pColor
{
    NSString* pStr = [[pColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([pStr length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([pStr hasPrefix:@"0X"])
        pStr = [pStr substringFromIndex:2];
    if ([pStr hasPrefix:@"#"])
        pStr = [pStr substringFromIndex:1];
    if ([pStr length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [pStr substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [pStr substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [pStr substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(NSString *)base64DecodeWithString:(NSString *)pstrBase64String
{
    NSData *pBase64Data = [[NSData alloc]initWithBase64EncodedString:pstrBase64String options:0];
    NSString *pstrString = [[NSString alloc]initWithData:pBase64Data encoding:NSUTF8StringEncoding];
    return pstrString;
}

- (NSString *)detail{
    return [_detail removeHtmlTagsAndUrl];
}

@end


@implementation SheQuZanModel

/**
 *   添加空视图
 *
 */
+(UIView *)AddUIViewWithImage:(UIImage *)image Point:(CGPoint)Point text:(NSString *)text{
    UIView *nullView = [[UIView alloc]initWithFrame:CGRectMake(Point.x, Point.y, 128, 113+5+60)];
    UIImageView *nullImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 128, 113)];
    [nullView addSubview:nullImageView];
    nullImageView.image = image;
    UILabel *nullLabel = [[UILabel alloc]initWithFrame:CGRectMake(-40, 113+5,128+80, 60)];
    [nullView addSubview:nullLabel];
    nullLabel.text = text;
    nullLabel.font = [UIFont systemFontOfSize:16];
    nullLabel.textAlignment = NSTextAlignmentCenter;
    nullLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nullLabel.numberOfLines = 0;
    nullLabel.textColor = [UIColor redColor];
    return nullView;
}
@end

@implementation SheQuReplyModel
//将UIView部分截取成UIimage图片格式
+(UIImage *)ClipToImageFromUIView:(UIView *)pBigView CGRect:(CGRect)rect{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(pBigView.bounds.size, NO, [UIScreen mainScreen].scale);
    [pBigView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*pBigViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef pCgImageRef = pBigViewImage.CGImage;
    CGFloat pRectY = rect.origin.y*2;
    CGFloat pRectX = rect.origin.x*2;
    CGFloat pRectWidth = rect.size.width*2;
    CGFloat pRectHeight = rect.size.height*2;
    CGRect pToRect = CGRectMake(pRectX, pRectY, pRectWidth, pRectHeight);
    CGImageRef imageRef = CGImageCreateWithImageInRect(pCgImageRef, pToRect);
    UIImage *pToImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return pToImage;
}

@end
