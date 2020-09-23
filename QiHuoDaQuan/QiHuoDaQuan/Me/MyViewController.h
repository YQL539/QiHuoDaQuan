//
//  MyViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/16.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuTableViewCell.h"
#import "SheQuModel.h"
#import "SheQuLunchViewController.h"
#import "SheQuDetailViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *discussTableView;
@property (strong, nonatomic) NSMutableArray *discussArray;
@property (nonatomic,copy)NSString *type;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;
@end

NS_ASSUME_NONNULL_END
