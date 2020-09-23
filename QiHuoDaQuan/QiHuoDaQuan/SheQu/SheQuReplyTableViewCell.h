//
//  SheQuReplyTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/16.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol SheQuReplyCellDelegate <NSObject>

-(void)SheQuReplyJBBtnDidClicked:(UIButton *)sender;

@end
@interface SheQuReplyTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat iTitleH;
@property (nonatomic,strong) UIButton *juBaoBtn;
@property (nonatomic,assign) id<SheQuReplyCellDelegate> replyDelegate;
- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
   willMoveToIndexPath:(NSIndexPath *)destinationIndexPath;
- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
    didMoveToIndexPath:(NSIndexPath *)destinationIndexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView
canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
    canMoveToIndexPath:(NSIndexPath *)destinationIndexPath;

+(instancetype)initReplyCellWithtableView:(UITableView *)tableview;
-(void)showDataWithModel:(SheQuReplyModel *)model;

@end

NS_ASSUME_NONNULL_END
