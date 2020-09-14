//
//  AlertWKWebview.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MQGradientProgressView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlertWKWebview : UIView
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIView *underView;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic,assign) CGFloat underViewHeight;
@property (nonatomic,assign)CGFloat iTitleHight;
@property (nonatomic,assign) CGFloat icor;
@property (nonatomic, strong) MQGradientProgressView *progressBar;
-(instancetype)initAlertWKWebviewWithFrame:(CGRect)frame;
-(void)loadUrl:(NSURL *)url;
-(void)removeAlertWKWebview;
@end

NS_ASSUME_NONNULL_END
