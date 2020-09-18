//
//  MarketViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import "MarketViewController.h"
#import "ScrollHeaderView.h"
#import "marketTableViewCell.h"
#import "data.h"
#import "LineViewController.h"

@interface MarketViewController ()<UITableViewDelegate,UITableViewDataSource,ScrollHeaderViewDelegate>
@property (strong, nonatomic) ScrollHeaderView *scrollHeaderView;
@property (assign, nonatomic) NSInteger seleIndex;
@property (nonatomic,strong) UITableView *homeTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation MarketViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:[data getDataWithRootTitle:@"shouye" subTitle:@"shanghai"]];
        [_dataArray addObject:[data getDataWithRootTitle:@"shouye" subTitle:@"zhengzhou"]];
        [_dataArray addObject:[data getDataWithRootTitle:@"shouye" subTitle:@"dalian"]];
        [_dataArray addObject:[data getDataWithRootTitle:@"shouye" subTitle:@"waipan"]];
        [_dataArray addObject:[data getDataWithRootTitle:@"shouye" subTitle:@"zhishu"]];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
}

-(void)setTableView{
    self.seleIndex = 0;
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT + 5, SCREENWIDTH, 40)];
    [self.view addSubview:search];
    search.backgroundColor = [UIColor whiteColor];
    search.barTintColor = [UIColor whiteColor];
    search.placeholder = @"请输入要搜索的内容";

    NSArray *titleArray = @[@"上海期货交易所",@"郑州期货交易所",@"大连期货交易所",@"外盘期货交易所",@"指数期货"];
    self.scrollHeaderView = [[ScrollHeaderView alloc] initScrollViewWithTitle:titleArray andRect:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 50, SCREENWIDTH, 40)];
    self.scrollHeaderView.headDelegate = self;
    [self.view addSubview:self.scrollHeaderView];
    
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollHeaderView.frame), SCREENWIDTH,  SCREENHEIGHT - TAB_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - 50 - 40) style:UITableViewStylePlain];
    [self.view addSubview:self.homeTableView];
    self.homeTableView.backgroundColor = [UIColor clearColor];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    marketTableViewCell *cell = [marketTableViewCell initCellWithTableView:tableView];
     if (self.dataArray.count) {
         cell.model = self.dataArray[self.seleIndex][indexPath.row];
     }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat iWidth = (SCREENWIDTH)/4;
    CGFloat iHeight = 30;
    UIView *titlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, iHeight)];
    titlView.backgroundColor = [UIColor whiteColor];
    [titlView addSubview:[self createTitleLabelWithTitle:@"名称" frame:CGRectMake(0, 0, iWidth + 30, iHeight)]];
    [titlView addSubview:[self createTitleLabelWithTitle:@"最新价格" frame:CGRectMake((iWidth) + 30, 0, iWidth-10, iHeight)]];
    [titlView addSubview:[self createTitleLabelWithTitle:@"涨幅" frame:CGRectMake((iWidth) * 2 + 30 - 10, 0, iWidth - 10, iHeight)]];
    [titlView addSubview:[self createTitleLabelWithTitle:@"推荐指数" frame:CGRectMake((iWidth) * 3 + 30 -10 -10, 0, iWidth -10, iHeight)]];
    return titlView;
}

-(UILabel *)createTitleLabelWithTitle:(NSString *)title frame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[self.seleIndex] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dataModel *model = self.dataArray[self.seleIndex][indexPath.row];
    LineViewController *detail = [[LineViewController alloc]init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark --- HangQingHeaderDelegate
- (void)didSelectItemWithIndex:(NSInteger)index {
    self.seleIndex = index;
    [self.homeTableView reloadData];
}

@end
