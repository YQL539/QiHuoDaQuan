//
//  MyViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/16.
//  Copyright © 2020 Y. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.discussArray.count == 0) {
        if ([self.type isEqualToString:@"收藏"]) {
            self.title = @"我的收藏";
            [self showAlertWithTitle:@"提示" Infomation:@"您还没有收藏帖子" completedAction:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }else{
        [self.view addSubview:self.discussTableView];
    }
}
#pragma mark ---- 懒加载
-(void)showAlertWithTitle:(NSString *)Title Infomation:(NSString *)information completedAction:(void(^_Nullable)(UIAlertAction *action))showAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:showAction];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (UITableView *)discussTableView {
    if (!_discussTableView) {
        _discussTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, SCREENHEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _discussTableView.backgroundColor = [UIColor whiteColor];
        _discussTableView.delegate = self;
        _discussTableView.dataSource = self;
    }
    return _discussTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return self.discussArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        SheQuModel *model = self.discussArray[indexPath.row];
        SheQuTableViewCell *cell = [SheQuTableViewCell initCellWithtableView:tableView];
        [cell showDataWithModel:model];
        return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return GetWidth(100.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SheQuModel *model;
    model = self.discussArray[indexPath.row];
    SheQuDetailViewController *detail = [[SheQuDetailViewController alloc]init];
    detail.qid = model.qi;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
