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

- (NSString *)detail{
    return [_detail removeHtmlTagsAndUrl];
}

@end


@implementation SheQuZanModel

@end

@implementation SheQuReplyModel


@end
