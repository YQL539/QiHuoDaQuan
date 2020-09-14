//
//  ImageButton.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ImageButtonStyle){
    ImageButtonStyleTop,       // 图片在上，文字在下
    ImageButtonStyleLeft,      // 图片在左，文字在右
    ImageButtonStyleRight,     // 图片在右，文字在左
    ImageButtonStyleBottom,    // 图片在下，文字在上
};
@interface ImageButton : UIButton
/**
 ImageButton的样式(Top、Left、Right、Bottom)
 */
@property (nonatomic, assign) ImageButtonStyle style;

/**
 图片和文字的间距
 */
@property (nonatomic, assign) CGFloat space;

/**
 整个ImageButton(包含ImageV and titleV)的内边距
 */
@property (nonatomic, assign) CGFloat delta;
@end

NS_ASSUME_NONNULL_END
