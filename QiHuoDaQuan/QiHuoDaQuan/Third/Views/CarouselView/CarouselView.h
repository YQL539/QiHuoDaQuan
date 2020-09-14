//
//  CarouselView.h
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/14.
//  Copyright © 2020 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CarouselView;
@protocol CarouselViewDelegate <NSObject>
@optional
/** 监听点击的图片和位置 */
- (void)carouselView:(CarouselView *)banner didClickImageAtIndex:(NSInteger)index;
@end
@interface CarouselView : UIView
/**图片数组 */
@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, weak) id<CarouselViewDelegate> delegate;
-(void)setPagecontrollHidden:(BOOL)hidden;
@end

NS_ASSUME_NONNULL_END
