//
//  marketTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "data.h"
NS_ASSUME_NONNULL_BEGIN
@class dataModel;
@interface marketTableViewCell : UITableViewCell
@property (strong, nonatomic) dataModel *model;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceNowLabel;
@property (strong, nonatomic) UILabel *priceChangeLabel;
@property (strong, nonatomic) UILabel *recumentLabel;
@property (strong, nonatomic) UIView  *lineView;

+(instancetype)initCellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
