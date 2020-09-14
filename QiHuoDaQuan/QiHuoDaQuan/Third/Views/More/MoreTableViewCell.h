//
//  MoreTableViewCell.h
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/13.
//  Copyright © 2020 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreTableViewCell : UITableViewCell
+(instancetype)moreCellWithtableView:(UITableView *)tableview;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *iconImage;
@end

NS_ASSUME_NONNULL_END
