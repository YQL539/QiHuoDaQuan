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
