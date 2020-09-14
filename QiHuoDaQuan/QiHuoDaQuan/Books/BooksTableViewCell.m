//
//  BooksTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import "BooksTableViewCell.h"

@implementation BooksTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)initCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"BooksTableViewCell";
    BooksTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[BooksTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.numberOfLines = 5;
    self.detailLabel.textColor = [UIColor lightGrayColor];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.detailLabel];

    self.line = [[UIView alloc] init];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iMarginH = GetWidth(15.f);
    CGFloat iMarginW = GetWidth(15.f);
    CGFloat iIconWidth = self.height - iMarginH * 2;
    self.iconView.frame = CGRectMake(SCREENWIDTH - iIconWidth - iMarginW, iMarginH, iIconWidth, iIconWidth);
    self.titleLabel.frame = CGRectMake(iMarginW, iMarginH, SCREENWIDTH - iMarginW * 3 - iIconWidth, 30);
    self.detailLabel.frame = CGRectMake(iMarginW, CGRectGetMaxY(self.titleLabel.frame), SCREENWIDTH - iMarginW * 3 - iIconWidth, self.height - 30 - iMarginH);
    self.line.frame = CGRectMake(0, self.height - 1.f, self.width, 1.f);
}

//填充cell
-(void)showDataWithModel:(bookModel *)model{
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.desc;
    //使用SDWebImage第三方库
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
}

@end
