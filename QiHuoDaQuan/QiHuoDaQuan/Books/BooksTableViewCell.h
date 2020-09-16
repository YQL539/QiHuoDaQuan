//
//  BooksTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bookModel.h"
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface BooksTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *line;
//填充cell
-(void)showDataWithModel:(bookModel *)model;
+(instancetype)initCellWithTableView:(UITableView *)tableview;

@end

NS_ASSUME_NONNULL_END
