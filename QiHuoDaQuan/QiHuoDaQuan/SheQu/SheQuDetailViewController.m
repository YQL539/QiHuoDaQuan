//
//  SheQuDetailViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuDetailViewController.h"

@interface SheQuDetailViewController ()

@end

@implementation SheQuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帖子详情";
    self.detailArray = [NSMutableArray array];
    [self setSubviews];
}

-(void)setSubviews{
    self.detailView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVIGATION_BAR_HEIGHT - 50) style:UITableViewStylePlain];
    _detailView.backgroundColor = [UIColor whiteColor];
    _detailView.delegate = self;
    _detailView.dataSource = self;
    [self.view addSubview:self.detailView];
    
    self.lunchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lunchBtn.frame = CGRectMake(15, CGRectGetMaxY(self.detailView.frame) + 5, SCREENWIDTH - 30, 40);
    [self.lunchBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [self.lunchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.lunchBtn.layer.cornerRadius = 5;
    self.lunchBtn.clipsToBounds= YES;
    self.lunchBtn.backgroundColor = MAINCOLOR;
    [self.lunchBtn addTarget:self action:@selector(setPinglun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lunchBtn];
    
    [self fetchData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"shoucang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(SheQuZanSCBtnDidClicked:)];
}

-(void)setPinglun{
    NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
    if (isLogin.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            SheQuLunchViewController *lunchVC = [[SheQuLunchViewController alloc]init];
            lunchVC.type = @"评论";
            [self.navigationController pushViewController:lunchVC animated:YES];
        });
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:loginVC animated:YES completion:nil];
        });
    }
}

#pragma mark ---- UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        return 30;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat iWidth = 80;
    CGFloat iHeight = 30;
    UIView *titlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, iHeight)];
    titlView.backgroundColor = RGB(241.f, 241.f, 241.f);
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, iWidth, iHeight)];
    if (section == 0) {
        nameLabel.text = @"原贴";
    }else{
        nameLabel.text = [NSString stringWithFormat:@"评论(%ld)",self.detailModel.answers.count];
    }
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [titlView addSubview:nameLabel];
    return titlView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.detailModel.answers.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SheQuDetailUITableViewCell *cell = [SheQuDetailUITableViewCell initSheQuDetailTableViewCellWithtableView:tableView];
        cell.delegate = self;
        [cell showSheQuDetailModelDataWithModel:self.detailModel];
        return cell;
    }
    
    if (indexPath.section == 1) {
        SheQuReplyModel *model = self.detailModel.answers[indexPath.row];
        SheQuReplyTableViewCell *cell = [SheQuReplyTableViewCell initReplyCellWithtableView:tableView];
        cell.replyDelegate = self;
        [cell showDataWithModel:model];
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGSize detailSize = [self getSizeWithText:self.detailModel.detail font:[UIFont systemFontOfSize:15] maxWidth:(SCREENWIDTH - GetWidth(15)*2)];
        return detailSize.height + GetWidth(140.f);
    }
    
    if (indexPath.section == 1) {
        SheQuReplyModel *model = self.detailModel.answers[indexPath.row];
        CGSize detailSize = [self getSizeWithText:model.answer_content font:[UIFont systemFontOfSize:16] maxWidth:(SCREENWIDTH - GetWidth(15)*2)];
        return detailSize.height + GetWidth(70.f);
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否举报该评论？" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self SheQuZanJBBtnDidClicked];
//            }];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            }];
//            [alertController addAction:alertAction];
//            [alertController addAction:cancelAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//        });
    }
}

- (void)fetchData{
    MBProgressHUD *requestHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       requestHub.mode = MBProgressHUDModeIndeterminate;
       requestHub.label.text = @"数据加载中。。。";
    NSString *tailStr = [NSString stringWithFormat:@"id-%@__p-1__more-true__no_answer-(null)",_qid];
    NSString *urlStr = [NSString stringWithFormat:@"https://app.jisilu.cn/api_v2/question/%@",tailStr];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"page"];
    [params setValue:@"true" forKey:@"more"];
    [params setValue:_qid forKey:@"qid"];
    [params setValue:@"" forKey:@"s"];
    [params setValue:@"" forKey:@"w"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue: @"text/html" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    [manager GET:urlStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [requestHub removeFromSuperview];
        NSString *result = [[NSString alloc] initWithData:responseObject
                                                 encoding:NSUTF8StringEncoding];
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&err];
        SheQuDetailModel *model = [[SheQuDetailModel alloc]initWithDictionary:resultDic[@"data"] error:nil];
        self.detailModel = model;
        if (self.detailModel) {
            [self.detailView reloadData];
        }else{
            [self showAlertWithTitle:@"提示" Infomation:@"该帖子因涉及违禁已被删除" completedAction:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [requestHub removeFromSuperview];
    }];
}

- (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

- (void)showHubWithMessage:(NSString *)message time:(NSInteger)time{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
        [hud hideAnimated:YES afterDelay:time];
        hud.removeFromSuperViewOnHide = YES;
    });
}

-(void)showAlertWithTitle:(NSString *)Title Infomation:(NSString *)information completedAction:(void(^_Nullable)(UIAlertAction *action))showAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:showAction];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)SheQuZanBtnDidClicked:(UIButton *)sender{
    NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
    if (isLogin.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showHubWithMessage:@"您赞了该帖子" time:1];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:loginVC animated:YES completion:nil];
        });
    }
}

-(void)SheQuZanSCBtnDidClicked:(UIButton *)sender{
    NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
    if (isLogin.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showHubWithMessage:@"您收藏了该帖子" time:1];
            [self collectModelToFile:kCollectArticle];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:loginVC animated:YES completion:nil];
        });
    }
}

-(void)SheQuZanPBBtnDidClicked:(UIButton *)sender{
    NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
    if (isLogin.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showHubWithMessage:@"您已屏蔽该帖子" time:1];
            [self showAlertWithTitle:@"提示" Infomation:@"您已屏蔽该帖子" completedAction:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:loginVC animated:YES completion:nil];
        });
    }
    
}

-(void)SheQuReplyJBBtnDidClicked:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否举报该评论？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self SheQuZanJBBtnDidClicked];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:alertAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

-(void)SheQuZanJBBtnDidClicked{
    NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
       if (isLogin.length > 0) {
            SheQuLunchViewController *lunchVC = [[SheQuLunchViewController alloc]init];
              lunchVC.type = @"举报";
              [self.navigationController pushViewController:lunchVC animated:YES];
       }else{
           dispatch_async(dispatch_get_main_queue(), ^{
               LoginViewController *loginVC = [[LoginViewController alloc]init];
               loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
               [self presentViewController:loginVC animated:YES completion:nil];
           });
       }
}

-(void)collectModelToFile:(NSString *)fileName {
    //把自定义的缓存文件 放在 沙盒/Library/Caches/MyCaches/ 里面
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    NSMutableArray *dataArray =  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!dataArray || dataArray.count == 0) {
        dataArray = [NSMutableArray array];
        [dataArray addObject:self.model];
        BOOL isOk =  [NSKeyedArchiver archiveRootObject:dataArray toFile:filePath];
            if (isOk) {
                NSLog(@"dataArray.count == 0好了");
            }else{
                NSLog(@"失败");
            }
    }else{
        NSMutableArray *saveArray = [NSMutableArray arrayWithArray:dataArray];
        BOOL isAdd = YES;
        for (SheQuModel *model in dataArray) {
            if ([model.qi isEqualToString:self.model.qi]) {
                isAdd = NO;
            }
        }
        if (isAdd == YES) {
            [saveArray addObject:self.model];
        }
        BOOL isOk =  [NSKeyedArchiver archiveRootObject:saveArray toFile:filePath];
        if (isOk) {
        }else{
            NSLog(@"失败");
        }
    }
}


@end
