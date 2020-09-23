//
//  NewsViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1小时快讯";
    self.newsArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    _newsTableView.backgroundColor = [UIColor clearColor];
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.newsTableView];
    [self getNews];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [NewsTableViewCell initCellWithtableView:tableView];
    if (self.newsArray.count) {
        newsModel *model = self.newsArray[indexPath.row];
        [cell showDataWithModel:model];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    newsModel *model = self.newsArray[indexPath.row];
    CGSize size = [model.title boundingRectWithSize:CGSizeMake(SCREENWIDTH - GetWidth(15.f) *3,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    return size.height + 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)getNews{
    __block typeof(self)weakSelf = self;
    MBProgressHUD *requestHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    requestHub.mode = MBProgressHUDModeIndeterminate;
    requestHub.label.text = @"数据加载中。。。";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *requestUrlString = [NSString stringWithFormat:@"http://huoqiu.591qiniu.com/api/v2/dp/news?page=1"];
        [manager GET:requestUrlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [requestHub removeFromSuperview];
            NSString *result = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
            NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&err];
            if ([resultDic[@"code"] longValue] == 200) {
                NSArray *listArray = resultDic[@"data"][@"cnt"][@"list"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if (listArray.count > 0) {
                        for (int i = 0; i<listArray.count; i++) {
                            NSDictionary *orderdic = listArray[i];
                            newsModel *model = [[newsModel alloc] init];
                            model.title = orderdic[@"content"];
                            NSString *time = orderdic[@"datetime"];
                            time = [time substringFromIndex:11];
                            model.time = time;
                            [weakSelf.newsArray addObject:model];
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.newsTableView reloadData];
                    });
                });
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [requestHub removeFromSuperview];
        }];
    });
}

@end
