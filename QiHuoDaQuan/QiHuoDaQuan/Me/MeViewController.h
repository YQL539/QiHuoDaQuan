//
//  MeViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/7.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MeViewController : UIViewController

{
    NSNotificationCenter* m_pDefaultCenter;
    NSMutableDictionary* m_pUpDic;
    NSString* m_pstrUpUrl;
    NSString* m_pstrPic;
    @public
    NSString* m_pstrExtra;
    NSString* m_pstrType;
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;
@end

NS_ASSUME_NONNULL_END
