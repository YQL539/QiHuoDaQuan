//
//  BookDetailViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/14.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bookModel.h"
#import "UIImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookDetailViewController : UIViewController
@property (nonatomic,strong) bookModel *bookData;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIImageView *bookImage;
@end

NS_ASSUME_NONNULL_END
