//
//  NavigationViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/6.
//  Copyright © 2020 Y. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.backgroundColor = [UIColor whiteColor];
    
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:20]};
    [navigationBar setTintColor:[UIColor blackColor]];
    navigationBar.barTintColor = [UIColor whiteColor];
}

//重写push后返回按钮的文字,文字可以为空字符串.
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >=1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
    // 首页不需要隐藏tabbars
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}

-(UIBarButtonItem *)creatBackButton {
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"leftArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    
}
-(void)popSelf {
    [self popViewControllerAnimated:YES];
    
}


@end
