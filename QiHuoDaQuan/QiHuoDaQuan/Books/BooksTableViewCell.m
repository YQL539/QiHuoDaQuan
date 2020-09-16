//
//  BooksTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import "BooksTableViewCell.h"

@implementation BooksTableViewCell

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
       self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        
        self.authorLabel = [[UILabel alloc] init];
        self.authorLabel.font = [UIFont systemFontOfSize:16];
        self.authorLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.authorLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.font = [UIFont systemFontOfSize:14];
        self.detailLabel.numberOfLines = 4;
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.detailLabel];

        self.line = [[UIView alloc] init];
        [self.contentView addSubview:self.line];
    }
    return self;
}


//填充cell
-(void)showDataWithModel:(bookModel *)model{
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.desc;
    self.authorLabel.text = [NSString stringWithFormat:@"作者： %@",model.author];
    
    //使用SDWebImage第三方库
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iMarginH = GetWidth(15.f);
    CGFloat iMarginW = GetWidth(15.f);
    CGFloat iIconWidth = self.height - iMarginH*2;
    self.iconView.frame = CGRectMake(iMarginW, iMarginH, iIconWidth, iIconWidth);
    self.titleLabel.frame = CGRectMake(iIconWidth + iMarginW * 2, iMarginH, SCREENWIDTH - iMarginW * 3 - iIconWidth, 40);
    self.authorLabel.frame = CGRectMake(iIconWidth + iMarginW*2, CGRectGetMaxY(self.titleLabel.frame), SCREENWIDTH - iMarginW * 3 - iIconWidth, 20);
     self.detailLabel.frame = CGRectMake(iIconWidth + iMarginW *2, CGRectGetMaxY(self.authorLabel.frame), SCREENWIDTH - iMarginW * 3 - iIconWidth, self.height - 20 - iMarginH - 20 - iMarginH *2);
    self.line.frame = CGRectMake(0, self.height - 1.f, self.width, 1.f);
}

@end
