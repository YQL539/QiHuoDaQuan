//
//  BookDetailViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/14.
//  Copyright © 2020 Y. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()
@property (nonatomic,assign) CGFloat iMarginW;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _iMarginW = 15;
    self.title = @"作品推荐";
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.text = _bookData.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.text = [NSString stringWithFormat:@"作者： %@",_bookData.author];
    self.authorLabel.font = [UIFont systemFontOfSize:16];
    self.authorLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.authorLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = [NSString stringWithFormat:@"推荐价格： %@元",[self GettRandomNumber:20 to:80]];
    self.priceLabel.font = [UIFont systemFontOfSize:16];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.priceLabel];
    
    UILabel *descTitle = [[UILabel alloc] init];
    descTitle.font = [UIFont systemFontOfSize:16];
    descTitle.text = @"作品简介：";
    descTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:descTitle];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = _bookData.desc;
    self.detailLabel.textColor = [UIColor darkGrayColor];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.detailLabel adjustsFontSizeToFitWidth];
    [self.view addSubview:self.detailLabel];
    
    self.bookImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.bookImage sd_setImageWithURL:[NSURL URLWithString:_bookData.images] placeholderImage:nil];
    [self.view addSubview:_bookImage];
    
     __block typeof(self)weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(weakSelf.iMarginW);
        make.right.equalTo(weakSelf.view).offset(-weakSelf.iMarginW);
        make.top.mas_equalTo(weakSelf.view).offset(NAVIGATION_BAR_HEIGHT + weakSelf.iMarginW);
        make.height.mas_equalTo(40);
    }];
    
    [_bookImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset((SCREENWIDTH - 180)/2);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.iMarginW);
        make.height.mas_equalTo(240);
        make.width.mas_equalTo(180);
    }];

    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.bookImage.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(descTitle);
        make.top.mas_equalTo(weakSelf.authorLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [descTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(descTitle);
        make.top.mas_equalTo(descTitle.mas_bottom).offset(5);
        make.height.mas_equalTo(180);
    }];
    
}

-(NSString *)GettRandomNumber:(int)iFrom to:(int)iTo
{
    CGFloat iRe = (CGFloat)(iFrom + (arc4random() % (iTo - iFrom + 1)));
    NSString *retStr = [NSString stringWithFormat:@"%.0f",iRe];
    return retStr;
}

@end
