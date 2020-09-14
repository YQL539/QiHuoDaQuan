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
- (instancetype)initScrollViewWithTitle:(NSArray *)titleArray andRect:(CGRect)rect;

@property (assign, nonatomic) id<ScrollHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
