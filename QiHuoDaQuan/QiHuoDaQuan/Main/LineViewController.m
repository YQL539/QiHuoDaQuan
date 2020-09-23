//
//  LineViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import "LineViewController.h"

@interface LineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *lineTabView;
@property (nonatomic,strong) NSArray *lineArray;

@end

@implementation LineViewController

-(NSString *)GettRandomNumber:(int)iFrom to:(int)iTo
{
    CGFloat iRe = (CGFloat)(iFrom + (arc4random() % (iTo - iFrom + 1)));
    NSString *retStr = [NSString stringWithFormat:@"%.0f",iRe];
    return retStr;
}

//计算文本宽度
- (CGFloat)calcWidthWithTitle:(NSString *)title font:(CGFloat)font {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    CGFloat realWidth = ceilf(rect.size.width);
    return realWidth;
}

-(void)getLineData{
    NSString *waiP = [NSString stringWithFormat:@"%@万",[self GettRandomNumber:500 to:1200]];
    NSString *neiP = [NSString stringWithFormat:@"%@万",[self GettRandomNumber:500 to:1200]];
    NSString *dayIncrease = [NSString stringWithFormat:@"%@",[self GettRandomNumber:5000 to:12000]];
    NSString *dayJie = [NSString stringWithFormat:@"%@",[self GettRandomNumber:4000 to:5500]];
    NSString *chiCang = [NSString stringWithFormat:@"%@万",[self GettRandomNumber:1000 to:5500]];
    NSString *qianJie = [NSString stringWithFormat:@"%@",[self GettRandomNumber:4000 to:5500]];
    NSString *zhouZ = [NSString stringWithFormat:@"%@%%",[self GettRandomNumber:1 to:30]];
    self.lineArray = @[
        @{@"title":@"名称",@"detail":self.model.name},
        @{@"title":@"现价",@"detail":self.model.buyPrice},
        @{@"title":@"涨跌",@"detail":self.model.kuiSun},
        @{@"title":@"涨幅",@"detail":self.model.zhangFu},
        @{@"title":@"净流入",@"detail":waiP},
        @{@"title":@"净流出",@"detail":neiP},
        @{@"title":@"分时量",@"detail":dayJie},
        @{@"title":@"换手率",@"detail":zhouZ},
        @{@"title":@"日增",@"detail":dayIncrease},
        @{@"title":@"持仓",@"detail":chiCang},
        @{@"title":@"前值",@"detail":qianJie},
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getLineData];
    [self setSubView];
}

-(void)setSubView{
    self.title = self.model.name;
    self.lineTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.lineTabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineTabView];
    _lineTabView.delegate = self;
    _lineTabView.dataSource = self;
    
    
    //定义一个容器视图来存放分享内容和两个操作按钮
    UIView *pContainer = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300) / 2, (self.view.frame.size.height - 400) / 2, 300, 400)];
    pContainer.layer.cornerRadius = 7;
    pContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    pContainer.layer.borderWidth = 1;
    pContainer.layer.masksToBounds = YES;
    pContainer.backgroundColor = [UIColor whiteColor];
    pContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    UIButton *pCancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [pCancelBtn setImage:[UIImage imageNamed:@"return_key"] forState:UIControlStateNormal];
    pCancelBtn.frame = CGRectMake(18, 16, 11, 17);
    [pCancelBtn addTarget:self action:@selector(cancelBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    UITableView *pTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 48, 300, 400)];
    pTableView.backgroundColor = [UIColor whiteColor];
    pTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    pTableView.dataSource = self;
    pTableView.delegate = self;
    pTableView.showsVerticalScrollIndicator = YES;
    [pTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return _lineArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat iWidth = SCREENWIDTH;
    CGFloat iHeight = 30;
    UIView *titlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, iHeight)];
    titlView.backgroundColor = [UIColor whiteColor];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, iWidth, iHeight)];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [titlView addSubview:nameLabel];
    NSString *title = @"";
    if (section == 0) {
        title = @"分时图";
    }
    if (section ==1) {
        title = @"指数";
    }
    nameLabel.text = title;
    return titlView;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LineImageCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LineImageCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, cell.frame.size.height)];
            image.tag = 100;
            [cell addSubview:image];
        }
        UIImageView *image = (UIImageView *) [cell viewWithTag:100];
        image.frame = CGRectMake(0, 0, SCREENWIDTH, 200);
        NSString *name = @"";
        if ([self.model.zhangFu containsString:@"-"]) {
            name = [self GettRandomNumber:6 to:10];
        }else{
            name = [self GettRandomNumber:1 to:5];
        }
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",name]];
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelCellInden"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"labelCellInden"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, (SCREENWIDTH - 20)/2, cell.frame.size.height)];
            title.textAlignment = NSTextAlignmentLeft;
            title.font = [UIFont systemFontOfSize:16];
            title.tag = 100;
            title.textColor = [UIColor blackColor];
            [cell addSubview:title];
            
            UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH - 20)/2+10, 0, (SCREENWIDTH - 20)/2, cell.frame.size.height)];
            detail.tag = 101;
            detail.font = [UIFont systemFontOfSize:16];
            detail.textColor = [UIColor blackColor];
            detail.textAlignment = NSTextAlignmentRight;
            [cell addSubview:detail];
        }
        UILabel *titleL = (UILabel *) [cell viewWithTag:100];
        UILabel *detailL = (UILabel *) [cell viewWithTag:101];
        NSString *title = self.lineArray[indexPath.row][@"title"];
        NSString *detail = self.lineArray[indexPath.row][@"detail"];
        titleL.text = title;
        detailL.text = detail;
        return cell;
        
    }else{
        return [UITableViewCell new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    }
    if (indexPath.section == 1) {
        return 40;
    }
    
    return 0;
}
@end
