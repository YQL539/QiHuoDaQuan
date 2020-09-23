//
//  SheQuTableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SheQuTableViewCell : UITableViewCell
{
    UIImagePickerController *m_pImagePicker;
    UICollectionView *m_pCollectionView;
    UITableView *m_pTableView;
    UIView *m_pTableViewHeader;
    NSMutableArray *m_pPictureArray;
    NSMutableArray *m_pThumbnailImagesArray;
    NSMutableArray *m_pOriginalImagesArray;
    UITextView *m_pTextView;
    UIActivityIndicatorView *m_pActivityView;
    CGFloat m_dHeight;
    NSString *m_pSelectAddr;
    NSString *m_pSelectLat;
    NSString *m_pSelectLong;
    UILabel *m_pAddressLabel;
    NSString* m_pstrCurrent;
}
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *lookView;
@property (nonatomic, strong) UILabel *lookLabel;
@property (nonatomic, strong) UIImageView *replyView;
@property (nonatomic, strong) UILabel *replyLabel;

- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

+(instancetype)initCellWithtableView:(UITableView *)tableview;
-(void)showDataWithModel:(SheQuModel *)model;
@end

NS_ASSUME_NONNULL_END
