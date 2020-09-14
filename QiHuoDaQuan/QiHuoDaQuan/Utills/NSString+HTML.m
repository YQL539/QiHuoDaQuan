//
//  NSString+HTML.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/6.
//  Copyright © 2020 Y. All rights reserved.
//

#import "NSString+HTML.h"

@implementation NSString (HTML)
- (NSString *)removeHtmlTagsAndUrl{
    NSString *string = self;
    NSString *HTMLTag = [string HTMLTagsInString];
    while (HTMLTag) {
        string = [string stringByReplacingOccurrencesOfString:HTMLTag withString:@""];
        HTMLTag = [string HTMLTagsInString];
    }
    NSString *URLString = [string URLInString];
    while (URLString) {
        string = [string stringByReplacingOccurrencesOfString:URLString withString:@""];
        URLString = [string URLInString];
    }
    return string;
}

- (BOOL)isContainHtmlString{
    NSString * regex = @"</?[^>]+>";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isContainURLString{
    NSString * regex = @"[a-zA-z]+://[a-zA-z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)HTMLTagsInString{
    NSError *error;
    NSString *rangeRegex = @"</?[^>]+>";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:rangeRegex options:0 error:&error];
    if (!error) {
        NSTextCheckingResult *match = [regular firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        if (match) {
            NSString *result = [self substringWithRange:match.range];
            return result;
        }
    }else{
        return nil;
    }
    return nil;
}

- (NSString  *)URLInString{
    NSError *error;
    NSString *rangeRegex = @"[a-zA-z]+://[/?a-zA-z.0-9/]*";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:rangeRegex options:0 error:&error];
    if (!error) {
        NSTextCheckingResult *match = [regular firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        if (match) {
            NSString *result = [self substringWithRange:match.range];
            return result;
        }
    }else{
        return nil;
    }
    return nil;
}
@end
