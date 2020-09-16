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

@interface SheQuDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SheQuDetailUITableViewCellDelegate>
@property (nonatomic,strong) UITableView *detailView;
@property (nonatomic,strong) SheQuDetailModel *detailModel;
@property (nonatomic,strong) NSMutableArray *detailArray;
@property(nonatomic,copy)NSString * qid;
@property (nonatomic,strong)SheQuModel *model;
@end

NS_ASSUME_NONNULL_END
