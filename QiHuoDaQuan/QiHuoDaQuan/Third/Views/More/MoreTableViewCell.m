//
//  MoreTableViewCell.m
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/13.
//  Copyright © 2020 com. All rights reserved.
//

#import "MoreTableViewCell.h"
@interface MoreTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *line;

@end
@implementation MoreTableViewCell

+(instancetype)moreCellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"MoreTableViewCell";
    MoreTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[MoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iIconWidth = GetWidth(30.f);
    CGFloat iMargin = GetWidth(15.f);
    self.iconView.frame = CGRectMake(iMargin, (self.frame.size.height - 1.f - iIconWidth)/2.f, iIconWidth, iIconWidth);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame) + GetWidth(15.f), 0, self.width - iIconWidth - GetWidth(60.f) - iMargin, self.frame.size.height - 1.f);
    self.line.frame = CGRectMake(0, self.frame.size.height - 1.f, self.frame.size.width, 1.f);
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setIconImage:(NSString *)iconImage{
    _iconImage = iconImage;
    _iconView.image = [UIImage imageNamed:iconImage];
}

@end
