//
//  MeTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeTableViewCell : UITableViewCell
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *iconImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placehodle;


+(instancetype)cellWithtableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
