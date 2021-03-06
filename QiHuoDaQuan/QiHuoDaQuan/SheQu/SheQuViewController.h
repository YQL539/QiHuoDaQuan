//
//  SheQuViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollHeaderView.h"
#import "SheQuTableViewCell.h"
#import "SheQuLunchViewController.h"
#import "SheQuModel.h"
#import "LoginViewController.h"
#import "DCCycleScrollView.h"

#import "SheQuDetailViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface SheQuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ScrollHeaderViewDelegate,DCCycleScrollViewDelegate>
{
    @public
    NSMutableArray *m_pImageArray;
    UIScrollView *m_pScrollView;
    UIView *m_pNavBar;
    NSUInteger m_iCurrentIndex;
    BOOL isBarHidden;
}

@property (strong, nonatomic) NSMutableArray *sheQuArray;
@property (nonatomic,strong)DCCycleScrollView *banner;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *topArray;
@property (strong, nonatomic) ScrollHeaderView *sheQuHeader;
@property (strong, nonatomic) UITableView *sheQuTableView;
@property(nonatomic, assign)NSInteger iType;
@property(nonatomic, assign)NSInteger nowPage;
@property(nonatomic, assign)BOOL isMore;
@property (assign, nonatomic) NSInteger seleIndex;

@end

NS_ASSUME_NONNULL_END
