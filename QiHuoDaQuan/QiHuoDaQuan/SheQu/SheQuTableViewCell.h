//
//  SheQuTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SheQuTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *lookView;
@property (nonatomic, strong) UILabel *lookLabel;

+(instancetype)initCellWithtableView:(UITableView *)tableview;
-(void)showDataWithModel:(SheQuModel *)model;
@end

NS_ASSUME_NONNULL_END
