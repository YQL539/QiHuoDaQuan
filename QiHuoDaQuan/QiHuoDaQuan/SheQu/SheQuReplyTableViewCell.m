//
//  SheQuReplyTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/16.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuReplyTableViewCell.h"

@implementation SheQuReplyTableViewCell

+(instancetype)initReplyCellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"SheQuReplyTableViewCell";
    SheQuReplyTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[SheQuReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

//填充cell
-(void)showDataWithModel:(SheQuReplyModel *)model{
    self.titleLabel.text = model.answer_content;
    self.authorLabel.text = model.user_name;
    self.timeLabel.text = model.add_time;
    [self.headView  sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"Default"]];
}

-(void)setViews{
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.headView = [[UIImageView alloc]init];
    [self.bgView addSubview:self.headView];
    
    self.authorLabel = [[UILabel alloc]init];
    self.authorLabel.font = [UIFont systemFontOfSize:14];
    self.authorLabel.textColor = [UIColor blackColor];
    [self.bgView addSubview:self.authorLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.bgView addSubview:self.timeLabel];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.bgView addSubview:self.titleLabel];
}

//重写布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iMarginX = GetWidth(15.f);
    CGFloat iMarginY = GetWidth(5.f);
    CGFloat iIconWidth = GetWidth(40.f);
    CGFloat iTitleHeight  =  [self getSizeWithText:self.titleLabel.text font:[UIFont systemFontOfSize:16] maxWidth:(SCREENWIDTH - iMarginX*2)].height;
    self.headView.frame = CGRectMake(iMarginX, iMarginY, iIconWidth, iIconWidth);
    self.authorLabel.frame = CGRectMake(CGRectGetMaxX(self.headView.frame) + iMarginX, iMarginY, SCREENWIDTH - iMarginX*2 - iIconWidth, iIconWidth);
    self.titleLabel.frame = CGRectMake(iMarginX, CGRectGetMaxY(self.headView.frame), SCREENWIDTH - iMarginX*2, iTitleHeight);
    self.timeLabel.frame = CGRectMake(iMarginX, CGRectGetMaxY(self.titleLabel.frame), SCREENWIDTH - iMarginX*4, iIconWidth/2);
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
