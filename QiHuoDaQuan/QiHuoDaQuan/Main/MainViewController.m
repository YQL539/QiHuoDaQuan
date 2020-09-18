//
//  MainViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import "MainViewController.h"
#import "AlertWKWebview.h"
#import "data.h"
#import "DCCycleScrollView.h"
#import "marketTableViewCell.h"
#import "ScrollHeaderView.h"
#import "CycleScrollView.h"
#import "LoginViewController.h"
#import "LineViewController.h"
#import "DateSignViewController.h"
#import "NewsViewController.h"
#import "BooksViewController.h"
@interface MainViewController ()<DCCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,ScrollHeaderViewDelegate>
@property (nonatomic,strong)DCCycleScrollView *banner;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *scrollBgView;
@property (nonatomic,strong)CycleScrollView *broadcastView;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) NSArray *boardArr;
@property (nonatomic,strong) UIView *btnBgView;
@property (strong, nonatomic) ScrollHeaderView *scrollHeaderView;
@property (assign, nonatomic) NSInteger seleIndex;
@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,strong) AlertWKWebview *alertWebview;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScrollView];
    [self setBannerView];
    [self setBroastView];
    [self setBtnView];
    [self setTableView];
    [self setAlertWKWebview];
}

-(void)setScrollView{
    self.scrollBgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:self.scrollBgView];
    _scrollBgView.scrollEnabled = YES;
    _scrollBgView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT*1.2);
    
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 40)];
    [_scrollBgView addSubview:search];
    search.placeholder = @"请输入要搜索的内容";

    
}

-(void)setBtnView{
    self.btnBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.broadcastView.frame)+5, SCREENWIDTH, 130)];
    [self.scrollBgView addSubview:self.btnBgView];
    CGFloat iMargin = 5;
    CGFloat iWidth = (SCREENWIDTH - iMargin * 4)/3;
    [self.btnBgView addSubview:[self getImageButtonWithTitle:@"每日签到" image:@"sign" tag:1000 frame:CGRectMake(iMargin, 5, iWidth, 60)]];
    [self.btnBgView addSubview:[self getImageButtonWithTitle:@"极速注册" image:@"regist" tag:1001 frame:CGRectMake(iWidth + iMargin*2, 5, iWidth, 60)]];
    [self.btnBgView addSubview:[self getImageButtonWithTitle:@"入门推荐" image:@"bookHome" tag:1002 frame:CGRectMake((iWidth + iMargin)*2 + iMargin, 5, iWidth, 60)]];
    [self.btnBgView addSubview:[self getImageButtonWithTitle:@"期货大盘" image:@"dati" tag:1003 frame:CGRectMake(iMargin, 70, iWidth, 60)]];
    [self.btnBgView addSubview:[self getImageButtonWithTitle:@"热门讨论" image:@"discuss" tag:1004 frame:CGRectMake((iWidth + iMargin) + iMargin, 70, iWidth, 60)]];
    [self.btnBgView addSubview:[self getImageButtonWithTitle:@"小时快讯" image:@"news" tag:1005 frame:CGRectMake((iWidth + iMargin)*2 + iMargin, 70, iWidth, 60)]];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:[data getDataWithRootTitle:@"HangQing" subTitle:@"NongChanPin"]];
        [_dataArray addObject:[data getDataWithRootTitle:@"HangQing" subTitle:@"yuanyou"]];
        [_dataArray addObject:[data getDataWithRootTitle:@"HangQing" subTitle:@"guijinshu"]];
    }
    return _dataArray;
}

-(void)setBannerView{
    self.banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 55, self.view.frame.size.width, 135) shouldInfiniteLoop:YES imageGroups:self.imageArr];
    _banner.autoScrollTimeInterval = 3;
    _banner.autoScroll = YES;
    _banner.isZoom = YES;
    _banner.delegate = self;
    _banner.imgCornerRadius = 10;
    _banner.itemWidth = self.view.frame.size.width - 100;
    [self.scrollBgView addSubview:self.banner];
    
    self.pageControl.frame = CGRectMake(0, 115, self.view.frame.size.width, 10);
    self.pageControl.numberOfPages = self.imageArr.count;
    self.pageControl.currentPage = 0;
    [self.banner addSubview:self.pageControl];
}

-(void)setBroastView{
    self.broadcastView = [[CycleScrollView alloc] initWithFrame:CGRectMake(10.f, CGRectGetMaxY(self.banner.frame)+5, self.view.frame.size.width - 20.f, 40.f)];
    [self.scrollBgView addSubview:_broadcastView];
    if (self.boardArr.count) {
       [_broadcastView configureShowTime:1.f animationTime:0.3f direction:CycleScrollViewScrollDirectionUp];
        _broadcastView.dataSource = self.boardArr;
    }
}

-(void)setAlertWKWebview{
    _alertWebview =  [[AlertWKWebview alloc] initAlertWKWebviewWithFrame:CGRectMake(30, SCREENHEIGHT, SCREENWIDTH-60, SCREENHEIGHT/10*8)];
    [self.view addSubview:_alertWebview];
    _alertWebview.layer.borderWidth = 1.0f;
    _alertWebview.layer.borderColor = MAINCOLOR.CGColor;
    _alertWebview.layer.cornerRadius = 5.0f;
     __block typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.alertWebview.frame = CGRectMake(30, SCREENHEIGHT/10, SCREENWIDTH-60, SCREENHEIGHT/10*8);
    } completion:nil];
    NSURL *url = [NSURL URLWithString:@"https://www.showdoc.cc/p/8e3df28fb3d37f9ec612559b29cc8f5f"];
    [_alertWebview loadUrl:url];
}

-(void)setTableView{
    self.seleIndex = 0;
    self.scrollHeaderView = [[ScrollHeaderView alloc] initScrollViewWithTitle:@[@"农产品",@"原油",@"贵金属"] andRect:CGRectMake(0, CGRectGetMaxY(self.btnBgView.frame) + 8, SCREENWIDTH, 40 - 8)];
    self.scrollHeaderView.headDelegate = self;
    [self.scrollBgView addSubview:self.scrollHeaderView];
    
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollHeaderView.frame), SCREENWIDTH,  SCREENHEIGHT*1.2 - TAB_BAR_HEIGHT - 40 - 55 - 130 - 135) style:UITableViewStylePlain];
    [self.scrollBgView addSubview:self.homeTableView];
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

-(void)buttonDidClicked:(UIButton *)button{
    NSInteger iTag = button.tag;
    switch (iTag) {
        case 1000:{
            DateSignViewController *signVC = [[DateSignViewController alloc] init];
            [self.navigationController pushViewController:signVC animated:YES];
            break;
        }
        case 1001:{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:loginVC animated:YES completion:nil];
            break;
        }
        case 1002:{
            BooksViewController *booksVC = [[BooksViewController alloc]init];
            [self.navigationController pushViewController:booksVC animated:YES];
            break;
        }
        case 1003:{
            [self.tabBarController setSelectedIndex:1];
            break;
        }
        case 1004:{
            [self.tabBarController setSelectedIndex:2];
            break;
        }
        case 1005:{
            NewsViewController *newVC = [[NewsViewController alloc]init];
            [self.navigationController pushViewController:newVC animated:YES];
            break;
        }
        default:{
            break;
        }
    }
}

-(ImageButton *)getImageButtonWithTitle:(NSString *)title image:(NSString *)imgName tag:(NSInteger)iTag frame:(CGRect)frame{
    ImageButton *button = [[ImageButton alloc]init];
    button.frame = frame;
    button.style = ImageButtonStyleTop;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    button.tag = iTag;
//    button.layer.borderColor = [UIColor blackColor].CGColor;
//    button.layer.borderWidth = .5f;
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark cycleScrollView delegate
-(void)cycleScrollView:(DCCycleScrollView *)cycleScrollView currentPageIndex:(NSInteger)index
{
    //设置当前页
    self.pageControl.currentPage = index;
}

-(UIPageControl *)pageControl
{
    if(_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

-(NSArray *)imageArr
{
    if(_imageArr == nil)
    {
        _imageArr = @[@"banner0.jpeg",
                      @"banner1.jpeg",
                      @"banner2.jpeg",
                      @"banner3.jpeg"
                      ];
    }
    return _imageArr;
}


-(NSArray *)boardArr{
    if(_boardArr == nil)
    {
        _boardArr = @[@"“世界500强企业”这位“金主”要买期货公司",
                      @"多读阅读相关期货书籍，能让你看懂行情。",
                      @"新手挑选期货的几大误区。",
                      @"未来航情：受阻暴跌 继续试空股指"
                      ];
    }
    return _boardArr;
}
@end
