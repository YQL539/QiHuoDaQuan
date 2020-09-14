//
//  HeadTableViewCell.h
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/13.
//  Copyright © 2020 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeadTableViewCell : UITableViewCell
+(instancetype)HeadCellWithtableView:(UITableView *)tableview;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailTitle;
@property (nonatomic, strong) UIImageView *iconView;
@end

NS_ASSUME_NONNULL_END
