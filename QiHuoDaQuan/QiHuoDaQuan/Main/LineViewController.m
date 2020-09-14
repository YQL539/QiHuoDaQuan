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
        @{@"title":@"今日价格",@"detail":self.model.buyPrice},
        @{@"title":@"今日涨跌",@"detail":self.model.kuiSun},
        @{@"title":@"今日涨幅",@"detail":self.model.zhangFu},
        @{@"title":@"外盘",@"detail":waiP},
        @{@"title":@"内盘",@"detail":neiP},
        @{@"title":@"现值",@"detail":dayJie},
        @{@"title":@"存货周转率",@"detail":zhouZ},
        @{@"title":@"日增",@"detail":dayIncrease},
        @{@"title":@"持仓",@"detail":chiCang},
        @{@"title":@"前值",@"detail":qianJie},
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLineData];
    [self setSubView];
}

-(void)setSubView{
    self.title = self.model.name;
    self.lineTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.lineTabView];
    _lineTabView.delegate = self;
    _lineTabView.dataSource = self;
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
        title = @"分时行情图";
    }
    if (section ==1) {
        title = @"指数指标";
    }
    nameLabel.text = title;
    return titlView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LineImageCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LineImageCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
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
            cell.backgroundColor = [UIColor clearColor];
            
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
