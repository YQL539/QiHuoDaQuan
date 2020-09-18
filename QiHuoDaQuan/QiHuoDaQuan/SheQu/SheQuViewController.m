//
//  SheQuViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuViewController.h"

@interface SheQuViewController ()

@end

@implementation SheQuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sheQuArray = [NSMutableArray array];
    self.topArray = [NSMutableArray array];
    self.seleIndex = 0;
    [self setSubviews];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setSubviews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"pinglun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(pushToWriteVC)];
    [self.view addSubview:self.sheQuHeader];
    [self.view addSubview:self.sheQuTableView];
    __block typeof(self)weakSelf = self;
    _sheQuTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.sheQuTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    self.sheQuTableView.backgroundColor = [UIColor whiteColor];
    [self loadNewData];
    [self setBannerView];
}

-(void)setBannerView{
    NSArray *imageArray = @[
    @"banner11.jpeg",
    @"banner22.jpeg",
    @"banner33.jpeg"
    ];
    
    self.banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 135) shouldInfiniteLoop:YES imageGroups:imageArray];
    _banner.autoScrollTimeInterval = 3;
    _banner.autoScroll = YES;
    _banner.isZoom = YES;
    _banner.delegate = self;
    _banner.imgCornerRadius = 10;
    _banner.itemWidth = self.view.frame.size.width - 100;
    
    self.pageControl.frame = CGRectMake(0, 115, self.view.frame.size.width, 10);
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
    [self.banner addSubview:self.pageControl];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}

-(void)pushToWriteVC{
    NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
    if (isLogin.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            SheQuLunchViewController *writeVC = [[SheQuLunchViewController alloc]init];
            writeVC.type = @"发布帖子";
            [self.navigationController pushViewController:writeVC animated:YES];
        });
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:loginVC animated:YES completion:nil];
        });
    }
  
}

#pragma mark ---- 懒加载
- (ScrollHeaderView *)sheQuHeader {
    if (!_sheQuHeader) {
        _sheQuHeader = [[ScrollHeaderView alloc] initScrollViewWithTitle:@[@"最新发布",@"热门讨论"] andRect:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, 40)];
        _sheQuHeader.headDelegate = self;
    }
    return _sheQuHeader;
}
- (UITableView *)sheQuTableView {
    if (!_sheQuTableView) {
        _sheQuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sheQuHeader.frame), SCREENWIDTH, SCREENHEIGHT - TAB_BAR_HEIGHT - CGRectGetMaxY(self.sheQuHeader.frame)) style:UITableViewStylePlain];
        _sheQuTableView.backgroundColor = [UIColor whiteColor];
        _sheQuTableView.delegate = self;
        _sheQuTableView.dataSource = self;
    }
    return _sheQuTableView;
}

- (void)endRefresh{
    if ([_sheQuTableView.mj_footer isRefreshing]) {
        [_sheQuTableView.mj_footer endRefreshing];
    }
    if ([_sheQuTableView.mj_header isRefreshing]) {
        [_sheQuTableView.mj_header endRefreshing];
    }
}
#pragma mark ---- UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 30;
    }else if(section == 2){
        return 30;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat iWidth = 80;
    CGFloat iHeight = 30;
    UIView *titlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, iHeight)];
    titlView.backgroundColor = RGB(241.0f, 241.0f, 241.0f);
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, iWidth, iHeight)];
    if (section == 0) {
        nameLabel.text = @"";
    }else if (section == 1) {
        nameLabel.text = @"置顶贴";
    }else if (section == 2) {
        nameLabel.text = @"话题贴";
    }else{
        nameLabel.text = @"";
    }
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [titlView addSubview:nameLabel];
    return titlView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return self.topArray.count;
    }
    if (section == 2) {
        return self.sheQuArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerCELL"];
        if (cell == nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BannerCELL"];
            cell.backgroundColor = [UIColor whiteColor];
            [cell addSubview:self.banner];
        }
        return cell;
    }
    
    if (indexPath.section == 1) {
        if (self.sheQuArray.count > 0) {
            SheQuModel *model = self.topArray[indexPath.row];
            SheQuTableViewCell *cell = [SheQuTableViewCell initCellWithtableView:tableView];
            [cell showDataWithModel:model];
            return cell;
        }
    }
    
    if (indexPath.section == 2) {
        if (self.sheQuArray.count > 0) {
            SheQuModel *model = self.sheQuArray[indexPath.row];
            SheQuTableViewCell *cell = [SheQuTableViewCell initCellWithtableView:tableView];
            [cell showDataWithModel:model];
            return cell;
        }
        
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 145;
    }else{
        return GetWidth(100.f);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SheQuModel *model;
    if (indexPath.section == 1) {
        model = self.topArray[indexPath.row];
        SheQuDetailViewController *detail = [[SheQuDetailViewController alloc]init];
        detail.qid = model.qi;
        detail.model = model;
        [self.navigationController pushViewController:detail animated:YES];
    }
    if (indexPath.section == 2) {
        model = self.sheQuArray[indexPath.row];
        SheQuDetailViewController *detail = [[SheQuDetailViewController alloc]init];
        detail.qid = model.qi;
        detail.model = model;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
}

#pragma mark --- HangQingHeaderDelegate
- (void)didSelectItemWithIndex:(NSInteger)index {
    self.seleIndex = index;
    [self loadNewData];
    [self.sheQuTableView reloadData];
}
- (void)loadNewData{
    _nowPage = 0;
    [self.sheQuArray removeAllObjects];
    [self fetchDataWithType:self.seleIndex];
}

- (void)loadMoreData{
    _nowPage = _nowPage++;
    [self fetchDataWithType:self.seleIndex];
}

- (void)fetchDataWithType:(NSInteger)iType{
    _iType = iType;
    NSString *type;
    if (_iType == 1) {
        type = @"hot";
    }else if (_iType == 0){
        type = @"new";
    }
    MBProgressHUD *requestHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    requestHub.mode = MBProgressHUDModeIndeterminate;
    requestHub.label.text = @"数据加载中。。。";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue: @"text/html" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    NSString *urlStr = @"https://app.jisilu.cn/api_v2/wenda/shequ/";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"20" forKey:@"contents_per_page"];
    [params setValue:@"true" forKey:@"fixed"];
    [params setValue:@(_nowPage + 1) forKey:@"page"];
    [params setValue:type forKey:@"type"];
    
    [manager GET:urlStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [requestHub removeFromSuperview];
        [self endRefresh];
        self.nowPage += 1;
        NSString *result = [[NSString alloc] initWithData:responseObject
                                                 encoding:NSUTF8StringEncoding];
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&err];
        NSArray *dataArr = [SheQuModel arrayOfModelsFromDictionaries:resultDic[@"data"] error:nil];
        [self.sheQuArray addObjectsFromArray:dataArr];
        //置顶数据
        if (resultDic[@"fixed"]) {
            NSMutableArray *dataArr2 = [SheQuModel arrayOfModelsFromDictionaries:resultDic[@"fixed"] error:nil];
            self.topArray = dataArr2;
        }
        
        [self.sheQuTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self endRefresh];
        [requestHub removeFromSuperview];
    }];
}

@end
