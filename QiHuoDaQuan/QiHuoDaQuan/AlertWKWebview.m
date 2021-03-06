//
//  AlertWKWebview.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import "AlertWKWebview.h"

@interface AlertWKWebview ()<WKUIDelegate, WKNavigationDelegate>

@end

@implementation AlertWKWebview
-(instancetype)initAlertWKWebviewWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubviews:frame];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setSubviews:(CGRect)frame{
    _bgView = [[UIView alloc]initWithFrame:CGRectZero];
    _bgView.layer.cornerRadius = 10;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - _underViewHeight)];
    self.webView.backgroundColor = [UIColor whiteColor];
    //创建网页配置对象
     WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
     _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
     _webView.UIDelegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
     _webView.navigationDelegate = self;
      [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
     [_bgView addSubview:_webView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.text = @"请阅读并接受协议";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    if (@available(iOS 8.2, *)) {
        _titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBlack];
    } else {
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_titleLabel];
    
    self.lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_bgView addSubview:_lineView];
    //按照进度显示
      self.progressBar = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), _bgView.frame.size.width, 3)];
      _progressBar.alwaysShowAllColor = NO;
    _progressBar.progress = 0.3f;
      _progressBar.colorArr = @[MQRGBColor(108, 171, 200), MQRGBColor(0, 0, 0), MQRGBColor(255, 207, 42)];
      [_bgView addSubview:_progressBar];
    
    _underView = [[UIView alloc] initWithFrame:CGRectZero];
    _underView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_underView];

    
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    _sureBtn.layer.cornerRadius = 10;
    [_sureBtn setTitle:@"同意并关闭" forState:UIControlStateNormal];
    _sureBtn.backgroundColor = MAINCOLOR;
    [_sureBtn addTarget:self action:@selector(sureBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_sureBtn];
}

+(NSString *)GetCurrentTime
{
    NSDateFormatter *pFormatter= [[NSDateFormatter alloc]init];
    [pFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *pstrTime = [pFormatter stringFromDate:[NSDate date]];
    return pstrTime;
    
}

-(void)sureBtnDidClicked:(UIButton *)button{
    [self removeAlertWKWebview];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.iTitleHight = 60;
    _underViewHeight = 85;
    _icor = 5;
    _bgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //预留出来的5是为了显示圆角
    _titleLabel.frame = CGRectMake(_icor, _icor, self.frame.size.width- _icor*2, _iTitleHight - _icor - 1);
    _lineView.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), self.frame.size.width, 1);
    _progressBar.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), self.frame.size.width, 3);
    _webView.frame = CGRectMake(0, CGRectGetMaxY(_lineView.frame), self.frame.size.width,  self.frame.size.height - _icor * 3 - _iTitleHight - 40);
    _underView.frame = CGRectMake(0, CGRectGetMaxY(_webView.frame), self.frame.size.width, _underViewHeight - _icor);

    _sureBtn.frame = CGRectMake(10, CGRectGetMaxY(_webView.frame) + 5, self.frame.size.width - 20, 40);
}

-(void)loadUrl:(NSURL *)url{
       NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:(NSURLRequestReloadIgnoringLocalCacheData) timeoutInterval:10.0];
       [self.webView loadRequest:mutableRequest];
}

-(void)removeAlertWKWebview{
    [self removeFromSuperview];
}

//判断是否是手机号码
+ (BOOL) IsValiddateMobile:(NSString*)pstrMobile
{
//    手机号以13.15.17。18开头
    NSString* pPhoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    
    NSPredicate* pPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pPhoneRegex];
    return [pPhoneTest evaluateWithObject:pstrMobile];
}

//判断是不是邮箱
+ (BOOL) IsValidateEmail:(NSString *)pEmail{
    NSString *pEmailCheck = @"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+[A-Za-z]{2,4}";
    NSPredicate *pEmailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pEmailCheck];
    return [pEmailTest evaluateWithObject:pEmail];
}

// 记得取消监听
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.progressBar.alpha = 1.0f;
        _progressBar.progress = newprogress;
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.progressBar.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                self->_progressBar.progress = 0.f;
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+(NSString *)FirstCharactor:(NSString *)pString
{
    //转成了可变字符串
    NSMutableString *pStr = [NSMutableString stringWithString:pString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pPinYin = [pStr capitalizedString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}


@end
