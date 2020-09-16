//
//  TopTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import "TopTableViewCell.h"
@interface TopTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) CGFloat iIconWidth;
@property (nonatomic, strong) UILabel *fsLabel;
@property (nonatomic, strong) UILabel *gzLabel;
@property (nonatomic, strong) UILabel *dtLabel;
@property (nonatomic, strong) UILabel *fenSiLabel;
@property (nonatomic, strong) UILabel *guanZhuLabel;
@property (nonatomic, strong) UILabel *dongTaiLabel;
@end
@implementation TopTableViewCell

+(instancetype)cellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"TopTableViewCell";
    TopTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[TopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
    
}

//重写布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.iIconWidth = GetWidth(60.f);
    if (isPad) {
        self.iIconWidth = GetWidth(60.f);
    }
    UIImageView *back = [[UIImageView alloc] init];
    back.image = [UIImage imageNamed:@"headBg"];
    self.backgroundView = back;
    
    self.iconView = [[UIImageView alloc] init];
    self.iconView.layer.cornerRadius = _iIconWidth / 2;
    self.iconView.clipsToBounds = YES;
    [self.contentView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];

    self.gzLabel = [self getLabelWithTitle:@"点赞"];
    [self.contentView addSubview:_gzLabel];
    self.dtLabel = [self getLabelWithTitle:@"动态"];
    [self.contentView addSubview:self.dtLabel];
    self.guanZhuLabel = [self getLabelWithTitle:@"0"];
    [self.contentView addSubview:self.guanZhuLabel];
    self.dongTaiLabel = [self getLabelWithTitle:@"0"];
    [self.contentView addSubview:self.dongTaiLabel];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat ImarginX = GetWidth(5);
    self.iconView.frame = CGRectMake((SCREENWIDTH - self.iIconWidth)/2, (self.height - _iIconWidth)/2.f - 30, self.iIconWidth, self.iIconWidth);
    if (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max) {
        //X上部分去掉比较好看
        self.iconView.centerY = (self.height - STATUS_BAR_HEIGHT)/2 + STATUS_BAR_HEIGHT - 25;
    }else{
        self.iconView.centerY = (self.height)/2 - 25;
    }
    self.titleLabel.frame = CGRectMake(ImarginX, CGRectGetMaxY(_iconView.frame), self.width, 20);
    self.gzLabel.frame = CGRectMake(ImarginX, CGRectGetMaxY(self.titleLabel.frame), (SCREENWIDTH - ImarginX*3)/2, 20);
    self.guanZhuLabel.frame = CGRectMake(ImarginX, CGRectGetMaxY(self.gzLabel.frame), (SCREENWIDTH - ImarginX*3)/2, 20);
    self.dtLabel.frame = CGRectMake(ImarginX + CGRectGetMaxX(self.gzLabel.frame), CGRectGetMaxY(self.titleLabel.frame), (SCREENWIDTH - ImarginX*3)/2, 20);
    self.dongTaiLabel.frame = CGRectMake(ImarginX + CGRectGetMaxX(self.gzLabel.frame), CGRectGetMaxY(self.dtLabel.frame), (SCREENWIDTH - ImarginX*3)/2, 20);
    self.line.frame = CGRectMake(0, self.height - 1.f, self.width, 1.f);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}


-(UILabel *)getLabelWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    return label;
}


@end
