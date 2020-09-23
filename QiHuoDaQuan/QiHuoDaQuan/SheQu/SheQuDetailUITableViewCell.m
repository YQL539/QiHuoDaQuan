//
//  SheQuDetailUITableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/16.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuDetailUITableViewCell.h"

@implementation SheQuDetailUITableViewCell


-(UIButton *)getButtonWithTitle:(NSString *)title tag:(NSInteger)iTag{
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = MAINCOLOR.CGColor;
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 5;
//    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.tag = iTag;
    [button addTarget:self action:@selector(cellButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)showSheQuDetailModelDataWithModel:(SheQuDetailModel *)model{
    self.titleLabel.text = model.content;
    self.contentLabel.text = model.detail;
    self.authorLabel.text = model.user_name;
    self.timeLabel.text = model.add_time;
    [self.headView  sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"Default"]];
}

+(instancetype)initSheQuDetailTableViewCellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"initSheQuDetailTableViewCellWithtableView";
    SheQuDetailUITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[SheQuDetailUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

-(void)cellButtonDidClicked:(UIButton *)sender{
    NSInteger iTag = sender.tag;
    switch (iTag) {
        case 1000:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(SheQuZanBtnDidClicked:)]) {
                [self.delegate SheQuZanBtnDidClicked:sender];
            }
            break;
        }
        case 1001:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(SheQuZanSCBtnDidClicked:)]) {
                [self.delegate SheQuZanSCBtnDidClicked:sender];
            }
            break;
        }
        case 1002:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(SheQuZanPBBtnDidClicked:)]) {
                [self.delegate SheQuZanPBBtnDidClicked:sender];
            }
            break;
        }
        case 1003:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(SheQuZanJBBtnDidClicked)]) {
                [self.delegate SheQuZanJBBtnDidClicked];
            }
            break;
        }
        default:{
            break;
        }
    }
    
}

+(void)addCoreBlurView:(UIView *)pView
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = pView.frame;
    [pView addSubview:effectview];
    [UIView animateWithDuration:3 animations:^{
        effectview.alpha = 0;
        effectview.alpha = 1;
    } completion:nil];
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
        [self setSubViews];
        self.zanBtn = [self getButtonWithTitle:@"赞" tag:1000];
        [self.zanBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [self addSubview:self.zanBtn];
        self.shouCangBtn = [self getButtonWithTitle:@"收藏" tag:1001];
        [self.shouCangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [self addSubview:self.shouCangBtn];
        self.pingBiBtn = [self getButtonWithTitle:@"屏蔽" tag:1002];
        [self.pingBiBtn setImage:[UIImage imageNamed:@"pingbi"] forState:UIControlStateNormal];
        [self addSubview:self.pingBiBtn];
        self.juBaoBtn = [self getButtonWithTitle:@"举报" tag:1003];
        [self.juBaoBtn setImage:[UIImage imageNamed:@"jubao"] forState:UIControlStateNormal];
        [self addSubview:self.juBaoBtn];
    }
    return self;
}

+(NSString *)base64EncodeWithString:(NSString *)pstrString
{
    NSData *pInfoData = [pstrString dataUsingEncoding:NSUTF8StringEncoding];
    NSString* pstrBase64String = [pInfoData base64EncodedStringWithOptions:0];
    return pstrBase64String;
}

-(void)setSubViews{
    
    
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
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.bgView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor lightGrayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
     CGFloat iTitleHeight  =  GetWidth(40.f);
    CGFloat iMarginX = GetWidth(15.f);
    CGFloat iMarginY = GetWidth(5.f);
    CGFloat iIconWidth = GetWidth(40.f);
    CGFloat iBtnH = GetWidth(30);
    CGFloat iBtnW = GetWidth(80);
    CGFloat iBtnMargin = (SCREENWIDTH - iBtnW*4)/5;
    CGSize iContentSize = [self getSizeWithText:self.contentLabel.text font:[UIFont systemFontOfSize:15] maxWidth:(SCREENWIDTH - iMarginX*2)];
    self.headView.frame = CGRectMake(iMarginX, iMarginY, iIconWidth, iIconWidth);
    self.authorLabel.frame = CGRectMake(CGRectGetMaxX(self.headView.frame) + iMarginX, CGRectGetMinY(self.headView.frame), SCREENWIDTH - iMarginX*2 - iIconWidth, iIconWidth/2);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.headView.frame) + iMarginX, CGRectGetMaxY(self.authorLabel.frame), SCREENWIDTH - iMarginX*4 - iIconWidth - iIconWidth/2 - 40, iIconWidth/2);
    self.titleLabel.frame = CGRectMake(iMarginX,CGRectGetMaxY(self.headView.frame), SCREENWIDTH - iMarginX*2, iTitleHeight);
    self.contentLabel.frame = CGRectMake(iMarginX, CGRectGetMaxY(self.titleLabel.frame), SCREENWIDTH - iMarginX*2, iContentSize.height);
    
    self.zanBtn.frame = CGRectMake(iBtnMargin, CGRectGetMaxY(self.contentLabel.frame)+ iMarginY, iBtnW,iBtnH );
    self.shouCangBtn.frame = CGRectMake(iBtnW + iBtnMargin*2, CGRectGetMaxY(self.contentLabel.frame)+ iMarginY, iBtnW,iBtnH);
    self.pingBiBtn.frame = CGRectMake(iBtnW*2 + iBtnMargin*3, CGRectGetMaxY(self.contentLabel.frame)+ iMarginY, iBtnW, iBtnH);
    self.juBaoBtn.frame = CGRectMake(iBtnW*3 + iBtnMargin*4, CGRectGetMaxY(self.contentLabel.frame) + iMarginY, iBtnW, iBtnH);
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

+(NSString *)base64DecodeWithString:(NSString *)pstrBase64String
{
    NSData *pBase64Data = [[NSData alloc]initWithBase64EncodedString:pstrBase64String options:0];
    NSString *pstrString = [[NSString alloc]initWithData:pBase64Data encoding:NSUTF8StringEncoding];
    return pstrString;
}
@end
