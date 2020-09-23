//
//  SheQuLunchViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SheQuLunchViewController : UIViewController<UITextViewDelegate>
{
    UIImageView* m_pShareImgView;
    UILabel* m_pShareContentLabel;
    UILabel* m_pShareTitleLabel;
}
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic, strong) UIView *line;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton  *pushBtn;
@property (nonatomic,copy) NSString *type;


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
@end

NS_ASSUME_NONNULL_END
