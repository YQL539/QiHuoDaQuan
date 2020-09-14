//
//  AppDelegate.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/4.
//  Copyright © 2020 Y. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "bookModel.h"
@interface AppDelegate ()
@property(nonatomic,strong)NSMutableArray * chargeList;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
     self.window.backgroundColor = [UIColor whiteColor];
     TabbarViewController *tabVC = [[TabbarViewController alloc] init];
     self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)getBooks{
    NSString *bookUrl = @"https://d.wanjinig.cn/yapi/book/book_list?num=20&page=3&type=2";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    [manager GET:bookUrl parameters:nil headers:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = [bookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        self.chargeList = [NSMutableArray arrayWithArray: array];
        [self getMoreBook];
    } failure:nil];
}

-(void)getMoreBook{
    NSString *bookUrl = @"https://d.wanjinig.cn/yapi/book/book_list?num=20&page=4&type=1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    [manager GET:bookUrl parameters:nil headers:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = [bookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [self.chargeList addObjectsFromArray:array];
        NSData * mutData = [NSKeyedArchiver archivedDataWithRootObject:self.chargeList];
        [[NSUserDefaults standardUserDefaults] setObject:mutData forKey:@"mybooks"];
    } failure:nil];
}
@end
