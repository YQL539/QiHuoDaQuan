//
//  NewsTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconView;

+(instancetype)initCellWithtableView:(UITableView *)tableview;
//填充cell
-(void)showDataWithModel:(newsModel *)model;
@end

NS_ASSUME_NONNULL_END
