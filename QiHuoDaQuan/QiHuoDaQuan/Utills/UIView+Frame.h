//
//  UIView+Frame.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/4.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)
#pragma mark - Origin
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
#pragma mark - Size
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
#pragma mark - Center
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
#pragma mark - Coords
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@end


@interface UIView (FindFirstResponder)
- (UIView *)findFirstResponder;
@end

NS_ASSUME_NONNULL_END
