//
//  SheQuModel.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuModel.h"

@implementation SheQuModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"headImage":@"avatar_url",
                                                                  @"nickName":@"un",
                                                                  @"date":@"st",
                                                                  @"content":@"qc",
                                                                  @"loolNum":@"vc",
                                                                  @"reply":@"ac",
    }];
}
@end
