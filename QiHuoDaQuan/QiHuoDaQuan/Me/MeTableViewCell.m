//
//  MeTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import "MeTableViewCell.h"
@interface MeTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *detailLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *line;

@end
@implementation MeTableViewCell
- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setIconImage:(NSString *)iconImage{
    _iconImage = iconImage;
    _iconView.image = [UIImage imageNamed:iconImage];
}

- (void)setPlacehodle:(NSString *)placehodle {
    _placehodle = placehodle;
    _detailLabel.placeholder = placehodle;
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.detailLabel.text = content;
}

+(instancetype)cellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"MeTableViewCell";
    MeTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[MeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
    
}

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
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UITextField alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:17];
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.alpha = 0.8;
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    self.detailLabel.userInteractionEnabled = NO;
    [self.contentView addSubview:self.detailLabel];

    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iIconWidth = GetWidth(20.f);
    if (isPad) {
        iIconWidth = GetWidth(20.f);
    }
    self.iconView.frame = CGRectMake(GetWidth(15.f), (self.height - 1.f - iIconWidth)/2.f, iIconWidth, iIconWidth);
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake((self.width - GetWidth(30.f) - GetWidth(15.f))/2.f - iIconWidth,self.height - 1.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame) + GetWidth(15.f), 0, size.width , self.height - 1.f);
    self.line.frame = CGRectMake(0, self.height - 1.f, self.width, 1.f);
}

@end
