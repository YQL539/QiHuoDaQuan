//
//  SheQuLunchViewController.h
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SheQuLunchViewController : UIViewController<UITextViewDelegate>
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic, strong) UIView *line;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton  *pushBtn;
@property (nonatomic,copy) NSString *type;
@end

NS_ASSUME_NONNULL_END
