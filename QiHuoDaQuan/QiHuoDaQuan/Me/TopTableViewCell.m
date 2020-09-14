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
@property (nonatomic, strong) UITextField *detailLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) CGFloat iIconWidth;
@property (nonatomic, strong) UIImageView *rightView;

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
    back.backgroundColor = MAINCOLOR;
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

    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = CGRectMake((self.size.width - self.iIconWidth)/2, (self.height - _iIconWidth)/2.f, self.iIconWidth, self.iIconWidth);
    if (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max) {
        //X上部分去掉比较好看
        self.iconView.centerY = (self.height - STATUS_BAR_HEIGHT)/2 + STATUS_BAR_HEIGHT;
    }else{
        self.iconView.centerY = (self.height)/2;
    }
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_iconView.frame), self.width, 30);
    self.line.frame = CGRectMake(0, self.height - 1.f, self.width, 1.f);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}





@end
