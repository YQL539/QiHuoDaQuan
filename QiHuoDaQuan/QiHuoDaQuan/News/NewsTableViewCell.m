//
//  NewsTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

//填充cell
-(void)showDataWithModel:(newsModel *)model{
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
}

+(instancetype)initCellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"NewsTableViewCell";
    NewsTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.numberOfLines = 1;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.textColor = MAINCOLOR;
        [self.bgView addSubview:self.timeLabel];
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.image = [UIImage imageNamed:@"time"];
        [self.bgView addSubview:self.iconView];
        
        
        self.leftView = [[UIImageView alloc] init];
        self.leftView.backgroundColor = MAINCOLOR;
        [self.bgView addSubview:self.leftView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.textColor = [UIColor blackColor];
        [self.bgView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iIconWidth = GetWidth(10.f);
    CGFloat iMargin = GetWidth(15.f);
    
    self.bgView.frame = CGRectMake(0, 0, self.width, self.height);
    self.iconView.frame = CGRectMake(iMargin/2, 10, iIconWidth, iIconWidth);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + iMargin, 10, SCREENWIDTH - iIconWidth - iMargin*2, iIconWidth);
    self.leftView.frame = CGRectMake(iMargin/2 + iIconWidth/2, CGRectGetMaxY(self.iconView.frame)+5, 1, self.height - iIconWidth);
    self.titleLabel.frame = CGRectMake(CGRectGetMinX(self.timeLabel.frame), CGRectGetMaxY(self.iconView.frame)+5, SCREENWIDTH - iMargin * 3 - iIconWidth, self.height - iIconWidth - iMargin/2);
}


@end
