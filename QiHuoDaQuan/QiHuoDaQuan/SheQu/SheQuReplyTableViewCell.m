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

//将UIView部分截取成UIimage图片格式
+(UIImage *)ClipToImageFromUIView:(UIView *)pBigView CGRect:(CGRect)rect{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(pBigView.bounds.size, NO, [UIScreen mainScreen].scale);
    [pBigView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*pBigViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef pCgImageRef = pBigViewImage.CGImage;
    CGFloat pRectY = rect.origin.y*2;
    CGFloat pRectX = rect.origin.x*2;
    CGFloat pRectWidth = rect.size.width*2;
    CGFloat pRectHeight = rect.size.height*2;
    CGRect pToRect = CGRectMake(pRectX, pRectY, pRectWidth, pRectHeight);
    CGImageRef imageRef = CGImageCreateWithImageInRect(pCgImageRef, pToRect);
    UIImage *pToImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return pToImage;
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
    [self addSubview:self.headView];
    
    self.authorLabel = [[UILabel alloc]init];
    self.authorLabel.font = [UIFont systemFontOfSize:14];
    self.authorLabel.textColor = [UIColor blackColor];
    [self addSubview:self.authorLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor grayColor];
    [self addSubview:self.timeLabel];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    
    
    self.juBaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.juBaoBtn setImage:[UIImage imageNamed:@"jubao"] forState:UIControlStateNormal];
    self.juBaoBtn.backgroundColor = [UIColor whiteColor];
    self.juBaoBtn.clipsToBounds = YES;
    self.juBaoBtn.layer.cornerRadius = 5;
     [self.juBaoBtn addTarget:self action:@selector(juBaoButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.juBaoBtn];
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
        [self setViews];
    }
    return self;
}

-(void)juBaoButtonDidClicked:(UIButton *)sender{
    if (self.replyDelegate && [self.replyDelegate respondsToSelector:@selector(SheQuReplyJBBtnDidClicked:)]) {
        [self.replyDelegate SheQuReplyJBBtnDidClicked:sender];
    }
}


+ (void) MastViewByImage:(UIView *)pMaskedView withMaskImage:(UIView *)pMaskImageView{
    UIImage* pImg = [self screenImage:pMaskImageView];
    CALayer *pMask = [CALayer layer];
    pMask.contents = (id)[pImg CGImage];
    pMask.frame = CGRectMake(0, 0, pImg.size.width , pImg.size.height );
    pMaskedView.layer.mask = pMask;
    pMaskedView.layer.masksToBounds = YES;
    pMaskedView.tag = 10;
}



//高斯模糊图片
+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //高斯模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[inputImage extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat iMarginX = GetWidth(15.f);
    CGFloat iMarginY = GetWidth(5.f);
    CGFloat iIconWidth = GetWidth(40.f);
    CGFloat iTitleHeight  =  [self getSizeWithText:self.titleLabel.text font:[UIFont systemFontOfSize:16] maxWidth:(SCREENWIDTH - iMarginX*2)].height;
    self.headView.frame = CGRectMake(iMarginX, iMarginY, iIconWidth, iIconWidth);
    self.authorLabel.frame = CGRectMake(CGRectGetMaxX(self.headView.frame) + iMarginX, iMarginY, SCREENWIDTH - iMarginX*2 - iIconWidth - 30, iIconWidth);
    self.titleLabel.frame = CGRectMake(iMarginX, CGRectGetMaxY(self.headView.frame), SCREENWIDTH - iMarginX*2 - 40, iTitleHeight);
    self.juBaoBtn.frame = CGRectMake(SCREENWIDTH - iMarginX - 25, iMarginY + 7, 25, 25);
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



+ (UIImage *) screenImage:(UIView *)pView {
    UIImage *pScreenImage;
    UIGraphicsBeginImageContext(pView.frame.size);
    [pView.layer renderInContext:UIGraphicsGetCurrentContext()];
    pScreenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pScreenImage;
}
@end
