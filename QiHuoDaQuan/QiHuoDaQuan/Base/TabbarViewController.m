//
//  TabbarViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/6.
//  Copyright © 2020 Y. All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray * array = [NSMutableArray new];
    MainViewController * viewController1 =[MainViewController new];
    [array addObject:viewController1];
    MarketViewController * viewController2 = [MarketViewController new];
    [array addObject:viewController2];
    SheQuViewController * viewController3 =[SheQuViewController new];
    [array addObject:viewController3];
    MeViewController * viewController4 =[MeViewController new];
    [array addObject:viewController4];
    
    NSArray * viewTitle =@[@"主页",@"市场",@"社区",@"更多"];
    NSArray * imagesNomal =@[@"Main",@"Mark",@"SheQu",@"Me"];
    NSArray * imagesSelect =@[@"MainSe",@"MarkSe",@"SheQuSe",@"MeSe"];
    for (int i = 0 ; i<array.count; i++) {
        UIViewController * viewController = array[i];
        viewController.title = viewTitle[i];
        viewController.tabBarItem.title = viewTitle[i];
        viewController.tabBarItem.image = [[UIImage imageNamed:imagesNomal[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:imagesSelect[i]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = [UIColor grayColor];
        NSMutableDictionary *dictionaryForTextSelect = [NSMutableDictionary dictionary];
        dictionaryForTextSelect[NSForegroundColorAttributeName] = MAINCOLOR;
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
        
        
        [viewController.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
        [viewController.tabBarItem setTitleTextAttributes:dictionaryForTextSelect forState:UIControlStateSelected];
        [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
        [UITabBar appearance].translucent = NO;
        
        
        NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:viewController];
         [self addChildViewController:nav];
    }
}


@end
