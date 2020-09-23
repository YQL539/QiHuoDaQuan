//
//  marketTableViewCell.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import "marketTableViewCell.h"


@implementation marketTableViewCell

+(instancetype)initCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"marketTableViewCell";
    marketTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[marketTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
- (UIImage *)cornerRadius:(CGFloat)cornerRadius size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//重写布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        
        self.priceNowLabel = [[UILabel alloc] init];
        self.priceNowLabel.textColor = [UIColor blackColor];
        self.priceNowLabel.textAlignment = NSTextAlignmentCenter;
        self.priceNowLabel.font =  [UIFont systemFontOfSize:15];
        
        self.priceChangeLabel = [[UILabel alloc] init];
        
        self.priceChangeLabel.textAlignment = NSTextAlignmentCenter;
        self.priceChangeLabel.layer.cornerRadius = 7;
        self.priceChangeLabel.clipsToBounds = YES;
        self.priceChangeLabel.font =  [UIFont systemFontOfSize:15];
        
        self.recumentLabel = [[UILabel alloc] init];
        self.recumentLabel.textColor = [UIColor blackColor];

        self.recumentLabel.textAlignment = NSTextAlignmentCenter;
        self.recumentLabel.font =  [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.priceNowLabel];
         [self.contentView addSubview:self.priceChangeLabel];
         [self.contentView addSubview:self.recumentLabel];
        
        //=======================================================================
        //定义一个容器视图来存放分享内容和两个操作按钮
           UIView *pContainer = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - 300) / 2, (self.frame.size.height - 175) / 2, 300, 170)];
           pContainer.layer.cornerRadius = 7;
           pContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
           pContainer.layer.borderWidth = 1;
           pContainer.layer.masksToBounds = YES;
           pContainer.backgroundColor = [UIColor whiteColor];
           pContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
           //定义Cancel按钮
           UIButton *pCancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
           [pCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
           pCancelBtn.frame = CGRectMake(5, 5, 70, 50);
           [pContainer addSubview:pCancelBtn];
           
           UITableView *pTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,pCancelBtn.frame.size.height, pContainer.frame.size.width - 10,pContainer.frame.size.height - 10 - pCancelBtn.frame.size.height)];
           pTableView.backgroundColor = [UIColor whiteColor];
           pTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

           [pTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
           [pContainer addSubview:pTableView];
        
        //=+=========================================================================
    }
    return self;
}

- (void)setModel:(dataModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.priceNowLabel.text = model.buyPrice;
    if ([model.zhangFu containsString:@"-"]) {
        self.priceChangeLabel.textColor = RGB(73.f, 128.f, 31.f);
    }else{
        self.priceChangeLabel.textColor = [UIColor redColor];
    }
    self.priceChangeLabel.text = model.zhangFu;
    
    NSString *reco = [self GettRandomNumber:70 to:100];
    self.recumentLabel.text = reco;
}

-(NSString *)GettRandomNumber:(int)iFrom to:(int)iTo
{
    CGFloat iRe = (CGFloat)(iFrom + (arc4random() % (iTo - iFrom + 1)));
    NSString *retStr = [NSString stringWithFormat:@"%.0f",iRe];
    return retStr;
}

+ (UIColor *)GetColor:(NSString *)pColor alpha:(CGFloat) dAlpha
{
    NSString* pStr = [[pColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([pStr length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([pStr hasPrefix:@"0X"])
        pStr = [pStr substringFromIndex:2];
    if ([pStr hasPrefix:@"#"])
        pStr = [pStr substringFromIndex:1];
    if ([pStr length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [pStr substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [pStr substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [pStr substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:dAlpha];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    CGFloat iMarginX = 15;
    CGFloat iW = (self.frame.size.width)/4;
    self.nameLabel.frame = CGRectMake(0, 0, iW + 30, self.frame.size.height);
    self.priceNowLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 0, iW - 10, self.height);
    self.priceChangeLabel.frame = CGRectMake(CGRectGetMaxX(self.priceNowLabel.frame), 10, iW - 10, self.height - 20);
    self.recumentLabel.frame = CGRectMake(CGRectGetMaxX(self.priceChangeLabel.frame), 0, iW - 10, self.height);
}

//计算文本高度
- (CGFloat)calcLabelHeight:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}
@end
