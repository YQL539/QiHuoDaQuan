//
//  TopTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopTableViewCell : UITableViewCell
{
    UILongPressGestureRecognizer * _longPressGestureRecognizer;
    UIPanGestureRecognizer * _panGestureRecognizer;
    NSIndexPath * _movingItemIndexPath;
    UIView * _beingMovedPromptView;
    CGPoint _sourceItemCollectionViewCellCenter;
    
    CADisplayLink * _displayLink;
    CFTimeInterval _remainSecondsToBeginEditing;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic,strong) UIButton *setButton;

+(instancetype)cellWithtableView:(UITableView *)tableview;

@end

NS_ASSUME_NONNULL_END
