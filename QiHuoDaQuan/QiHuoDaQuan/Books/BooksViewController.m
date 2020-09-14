//
//  BooksViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/11.
//  Copyright © 2020 Y. All rights reserved.
//

#import "BooksViewController.h"
#import "BooksTableViewCell.h"
@interface BooksViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *bookTableview;
@property(nonatomic,strong)NSMutableArray * bookList;

@end

@implementation BooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSString *bookUrl = @"https://d.wanjinig.cn/yapi/book/book_list?num=50&page=1&type=2";
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
