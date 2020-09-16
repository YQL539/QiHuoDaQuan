//
//  SheQuTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuTableViewCell.h"

@implementation SheQuTableViewCell

+(instancetype)initCellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"SheQuTableViewCell";
    SheQuTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[SheQuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

//填充cell
-(void)showDataWithModel:(SheQuModel *)model{
    self.titleLabel.text = model.content;
    self.authorLabel.text = model.nickName;
    self.timeLabel.text = model.date;
    self.lookLabel.text = model.loolNum;
    [self.headView  sd_setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"Default"]];
    
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
        
        self.headView = [[UIImageView alloc]init];
        self.headView.layer.cornerRadius = 5.f;
        self.headView.clipsToBounds = YES;
        [self.bgView addSubview:self.headView];
        
        self.lookView = [[UIImageView alloc]init];
        [self.bgView addSubview:self.lookView];
        self.lookView.image = [UIImage imageNamed:@"look"];
        
        self.authorLabel = [[UILabel alloc]init];
        self.authorLabel.font = [UIFont systemFontOfSize:14];
        self.authorLabel.textColor = [UIColor blackColor];
        [self.bgView addSubview:self.authorLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.bgView addSubview:self.timeLabel];
        
        self.lookLabel = [[UILabel alloc]init];
        self.lookLabel.font = [UIFont systemFontOfSize:12];
        self.lookLabel.textColor = [UIColor grayColor];
        [self.bgView addSubview:self.lookLabel];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.bgView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
     CGFloat iTitleHeight  =  GetWidth(50.f);
    CGFloat iMarginX = GetWidth(15.f);
    CGFloat iMarginY = GetWidth(5.f);
    CGFloat iIconWidth = GetWidth(90.f);
    self.headView.frame = CGRectMake(iMarginX, iMarginY, iIconWidth, iIconWidth);
    self.authorLabel.frame = CGRectMake(CGRectGetMaxX(self.headView.frame) + iMarginX, iMarginY, SCREENWIDTH - iMarginX*3 - iIconWidth, GetWidth(20));
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.headView.frame) + iMarginX, CGRectGetMaxY(self.authorLabel.frame),GetWidth(100), GetWidth(20));
    self.lookView.frame = CGRectMake(SCREENWIDTH - iMarginX - 2 - 100 - GetWidth(20.f), CGRectGetMinY(self.timeLabel.frame) + GetWidth(4.f), GetWidth(20.f), GetWidth(12.f));
    self.lookLabel.frame = CGRectMake(CGRectGetMaxX(self.lookView.frame) + 2, CGRectGetMinY(self.timeLabel.frame), 100, GetWidth(20));
    self.titleLabel.frame = CGRectMake(iIconWidth + iMarginX*2, CGRectGetMaxY(self.timeLabel.frame), SCREENWIDTH - iMarginX*2 - iIconWidth, iTitleHeight);
}

- (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

@end
