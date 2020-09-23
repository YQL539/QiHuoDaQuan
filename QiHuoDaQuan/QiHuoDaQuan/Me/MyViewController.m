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

-(void)showAlertWithTitle:(NSString *)Title Infomation:(NSString *)information completedAction:(void(^_Nullable)(UIAlertAction *action))showAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:showAction];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

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
        self.title = @"我的收藏";
        [self.view addSubview:self.discussTableView];
    }
}
#pragma mark ---- 懒加载

- (UITableView *)discussTableView {
    if (!_discussTableView) {
        _discussTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, SCREENHEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _discussTableView.backgroundColor = [UIColor whiteColor];
        _discussTableView.delegate = self;
        _discussTableView.dataSource = self;
    }
    return _discussTableView;
}

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:[NSDate date] options:0];
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

-(void)showAlertWithCustomeTitle:(NSString *)Title Infomation:(NSString *)information FirstBtnName:(NSString *)firstBtnName SecondBtn:(NSString *)SecondbtnName FirstAction:(void(^_Nullable)(UIAlertAction *action))firstAction SecondAction:(void(^_Nullable)(UIAlertAction *action))secondAction completedAction:(void (^ __nullable)(void))completedAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:firstBtnName style:UIAlertActionStyleDefault handler:firstAction];
    UIAlertAction *alert2Action = [UIAlertAction actionWithTitle:SecondbtnName style:UIAlertActionStyleDefault handler:secondAction];
    [alertController addAction:alertAction];
    [alertController addAction:alert2Action];
    [self presentViewController:alertController animated:YES completion:completedAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SheQuModel *model;
    model = self.discussArray[indexPath.row];
    SheQuDetailViewController *detail = [[SheQuDetailViewController alloc]init];
    detail.qid = model.qi;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
