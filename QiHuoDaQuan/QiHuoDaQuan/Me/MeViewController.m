//
//  MeViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import "MeViewController.h"
#import "TopTableViewCell.h"
#import "LoginViewController.h"
#import "MeTableViewCell.h"
#import <SafariServices/SafariServices.h>

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImage *headView;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic,strong) UIImage *headImage;

@end

@implementation MeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.headImage = [UIImage imageNamed:@"header"];
    [self setSubViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //登录后回到该界面时重新刷新数据
    [self.tableView reloadData];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.logoutBtn];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    self.automaticallyAdjustsScrollViewInsets =NO;
    }
    self.tableView.scrollEnabled = NO;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - TAB_BAR_HEIGHT - _logoutBtn.frame.size.height - GetWidth(30)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIButton *)logoutBtn{
    if (!_logoutBtn) {
        CGFloat iBtnHeight = GetWidth(50);
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.frame = CGRectMake(GetWidth(30), SCREENHEIGHT - TAB_BAR_HEIGHT - GetWidth(30) - iBtnHeight, SCREENWIDTH - GetWidth(30)*2,iBtnHeight);
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];;
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutBtn.backgroundColor = MAINCOLOR;
        [_logoutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.layer.cornerRadius = 5.0f;
        
    }
    return _logoutBtn;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //头像信息
            TopTableViewCell *cell = [TopTableViewCell cellWithtableView:tableView];
            cell.iconView.image = self.headImage;
            NSString *userAccount = [[userModel shareDataModel] getLoginAccout];
            if (userAccount.length > 0) {
                cell.title = userAccount;
            }else{
                cell.title = @"点击登录";
            }
            return cell;
            break;
        }
//        case 1:{
//
//            break;
//        }
        case 1:{
            MeTableViewCell *cell = [MeTableViewCell cellWithtableView:tableView];
            cell.title = @"我的收藏";
            cell.iconImage = @"Shoucangme";
            return cell;
            break;
        }
            
        case 2:{
            MeTableViewCell *cell = [MeTableViewCell cellWithtableView:tableView];
            cell.title = @"清理缓存";
            cell.iconImage = @"clear";
            return cell;
            break;
        }
        case 3:{
            MeTableViewCell *cell = [MeTableViewCell cellWithtableView:tableView];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            NSString *version = [NSString stringWithFormat:@"当前版本：%@",app_Version];
            cell.title = version;
            cell.iconImage = @"version";
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
            break;
        }
        case 4:{
            MeTableViewCell *cell = [MeTableViewCell cellWithtableView:tableView];
            cell.title = @"隐私协议";
            cell.iconImage = @"pravate";

            return cell;
            break;
        }
        case 5:{
            MeTableViewCell *cell = [MeTableViewCell cellWithtableView:tableView];
            cell.title = @"关于";
            cell.iconImage = @"about";
            return cell;
            break;
        }
        default:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LK_SettingVC"];
            if (cell == nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LK_SettingVC"];
            }
            return cell;
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //头像
            return 160.f;
            break;
        }
        default:{
            return 60.f;
            break;
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //头像
            NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
            if (isLogin.length > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showHubMessage:@"您已经登录" delay:3];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:loginVC animated:YES completion:nil];
                });
            }
            break;
        }
//        case 1:{
//            //自选
//            self.tabBarController.selectedIndex = 1;
//        }
        case 1:{
            //我的收藏
            NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
            if (isLogin.length > 0) {
                NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
                NSString *filePath = [cachePath stringByAppendingPathComponent:kCollectArticle];
                NSMutableArray *dataArray =  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                MyViewController *myCollectVC = [[MyViewController alloc] init];
                myCollectVC.discussArray = dataArray;
                myCollectVC.type = @"收藏";
                [self.navigationController pushViewController:myCollectVC animated:YES];
            }else {
                LoginViewController *loginVC = [LoginViewController new];
                loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:loginVC animated:YES completion:nil];
            }
           
            break;
        }
        case 2:{
            //清楚缓存
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showHubMessage:@"正在删除缓存文件" delay:3];
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));

                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self showHubMessage:@"清理完成！" delay:1];
                });
            });
            break;
        }
        case 3:{
            //当前版本
            break;
        }
        case 4:{
            //关于
            SFSafariViewController *sfVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://www.showdoc.cc/p/f7450f4e2af2d38a2e4545e769f0681e"]];
            [self.navigationController presentViewController:sfVC animated:YES completion:nil];
            break;
        }
            case 5:{
                //关于
                SFSafariViewController *sfVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://www.showdoc.cc/p/f7450f4e2af2d38a2e4545e769f0681e"]];
                [self.navigationController presentViewController:sfVC animated:YES completion:nil];
                break;
            }
        default:{
            break;
        }
    }
}
- (void)logOut {
    NSString *isLogin = [[userModel shareDataModel] getLoginAccout];
    if (isLogin.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确定退出登录？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[userModel shareDataModel] setLoginAccout:@""];
                [[userModel shareDataModel] setLoginPassword:@""];
                [self.tableView reloadData];
                [self showHubMessage:@"您已退出登录" delay:1];
            }];
            UIAlertAction *alert2Action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:alertAction];
            [alertController addAction:alert2Action];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }else{
        [self showHubMessage:@"您尚未登录，请先登录" delay:3];
    }
}

-(void)showHubMessage:(NSString *)message delay:(NSTimeInterval)time{
        MBProgressHUD *HUB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUB.mode = MBProgressHUDModeText;
        HUB.detailsLabel.text = message;
        [HUB hideAnimated:YES afterDelay:time];
        HUB.removeFromSuperViewOnHide = YES;
}

@end
