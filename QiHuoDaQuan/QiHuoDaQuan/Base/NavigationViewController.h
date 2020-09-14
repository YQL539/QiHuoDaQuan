//
//  NavigationViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/6.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavigationViewController : UINavigationController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
-(void)popSelf;
@end

NS_ASSUME_NONNULL_END
