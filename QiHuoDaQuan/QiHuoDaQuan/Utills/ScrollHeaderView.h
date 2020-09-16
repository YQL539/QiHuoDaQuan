//
//  ScrollHeaderView.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ScrollHeaderViewDelegate <NSObject>

@optional
- (void)didSelectItemWithIndex:(NSInteger)index;

@end
@interface ScrollHeaderView : UIView
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *colorView;
@property (strong, nonatomic) UIButton *lastButton;
@property (assign, nonatomic) id<ScrollHeaderViewDelegate> delegate;

- (instancetype)initScrollViewWithTitle:(NSArray *)titleArray andRect:(CGRect)rect;


@end

NS_ASSUME_NONNULL_END
