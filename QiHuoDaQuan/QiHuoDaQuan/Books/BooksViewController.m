//
//  BooksViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import "BooksViewController.h"
#import "BookDetailViewController.h"
#import "BooksTableViewCell.h"
@interface BooksViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *bookTableview;
@property(nonatomic,strong)NSMutableArray * bookList;

@end

@implementation BooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"入门推荐";
    
    if (@available(iOS 11.0, *)) {
        _bookTableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.bookTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_bookTableview];
    self.bookTableview.delegate = self;
    self.bookTableview.dataSource = self;
    self.bookTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getBooks];
    }];
    self.bookTableview.tableFooterView = [UIView new];
    [self.bookTableview.mj_header beginRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BooksTableViewCell *cell = [BooksTableViewCell initCellWithTableView:tableView];
    bookModel *model = self.bookList[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookList.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    bookModel *model = self.bookList[indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        BookDetailViewController *detailVC = [[BookDetailViewController alloc] init];
        detailVC.bookData = model;
        detailVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:detailVC animated:true];
    });
}
- (void)getBooks{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey: @"mybooks"];
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (array.count == 29) {
        self.bookList = [NSMutableArray arrayWithArray:array];
        [self.bookTableview reloadData];
        [self.bookTableview.mj_header endRefreshing];
        return;
    }
    //type：1=股票 2=期货 3=比特币 4=经济学，5：保险
    NSString *bookUrl = @"https://d.wanjinig.cn/yapi/book/book_list?num=10&page=2&type=1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    [manager GET:bookUrl parameters:nil headers:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = [bookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        self.bookList = [NSMutableArray arrayWithArray:array];
        [self.bookTableview reloadData];
        [self.bookTableview.mj_header endRefreshing];
    } failure:nil];
    
    
}

@end
