//
//  SheQuDetailUITableViewCell.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/16.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SheQuDetailUITableViewCellDelegate <NSObject>

-(void)SheQuZanBtnDidClicked:(UIButton *)sender;
-(void)SheQuZanSCBtnDidClicked:(UIButton *)sender;
-(void)SheQuZanPBBtnDidClicked:(UIButton *)sender;
-(void)SheQuZanJBBtnDidClicked;

@end

@interface SheQuDetailUITableViewCell : UITableViewCell
@property (nonatomic,assign) id<SheQuDetailUITableViewCellDelegate> delegate;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *zanBtn;
@property (nonatomic,strong) UIButton *shouCangBtn;
@property (nonatomic,strong) UIButton *pingBiBtn;
@property (nonatomic,strong) UIButton *juBaoBtn;


+(instancetype)initSheQuDetailTableViewCellWithtableView:(UITableView *)tableview;
-(void)showSheQuDetailModelDataWithModel:(SheQuDetailModel *)model;
@end

NS_ASSUME_NONNULL_END
