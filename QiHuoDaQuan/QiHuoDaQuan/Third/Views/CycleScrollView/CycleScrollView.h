//
//  CycleScrollView.h
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/14.
//  Copyright © 2020 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CycleScrollView;
typedef NS_ENUM(NSInteger, CycleScrollViewScrollDirection) {
    CycleScrollViewScrollDirectionUp = 0,
    CycleScrollViewScrollDirectionDown
};

@protocol CycleScrollViewDelegate <NSObject>
// 当前点击数据源的第几个item
- (void)CycleScrollView:(CycleScrollView *)view didClickItemIndex:(NSInteger)index;
@end

@interface CycleScrollView : UIView
@property (nonatomic, strong) NSArray *dataSource; // 数据源
@property (nonatomic, weak) id<CycleScrollViewDelegate> delegate;
/**
 设置DataSource之前调用
 
 @param showTime 展示时间
 @param animationTime 动画时间
 @param direction 方向
 */
- (void)configureShowTime:(double)showTime
            animationTime:(double)animationTime
                direction:(CycleScrollViewScrollDirection)direction;

// 开启动画 (主要用于进入其他页面返回时开启)
- (void)startAnimation;

// 关闭动画 (进入其他页面时调用)
- (void)stopAnimation;
@end

NS_ASSUME_NONNULL_END
