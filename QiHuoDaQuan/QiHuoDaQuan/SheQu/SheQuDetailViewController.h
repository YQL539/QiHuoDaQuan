//
//  SheQuDetailViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuDetailModel.h"
#import "SheQuModel.h"
#import "SheQuDetailUITableViewCell.h"
#import "SheQuLunchViewController.h"
#import "LoginViewController.h"
#import "SheQuReplyTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SheQuDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SheQuDetailUITableViewCellDelegate,SheQuReplyCellDelegate>
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

@property (nonatomic,strong) UITableView *sheQuDetailView;
@property (nonatomic, strong) UIButton *lunchBtn;
@property (nonatomic,strong) SheQuDetailModel *sheQuDetailModel;
@property (nonatomic,strong) NSMutableArray *detailArray;
@property(nonatomic,copy)NSString * qid;
@property (nonatomic,strong)SheQuModel *model;
@end

NS_ASSUME_NONNULL_END
