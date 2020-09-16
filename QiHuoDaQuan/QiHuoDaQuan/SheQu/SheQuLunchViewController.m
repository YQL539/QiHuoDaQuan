//
//  SheQuLunchViewController.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/15.
//  Copyright © 2020 Y. All rights reserved.
//

#import "SheQuLunchViewController.h"

@interface SheQuLunchViewController ()

@end

@implementation SheQuLunchViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)setSubViews{
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"请输入标题";
    self.textField.textColor = [UIColor blackColor];
    self.textField.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.textField];

    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textField.frame), SCREENWIDTH, GetWidth(260))];
    self.textView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), SCREENWIDTH, GetWidth(260));
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor blackColor];
    self.textView.delegate = self;
    self.textView.layer.borderWidth = .5f;
    self.textView.layer.borderColor = MAINCOLOR.CGColor;
    self.textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.textView];
    
    if ([self.type isEqualToString:@"发布帖子"]) {
        self.textField.frame = CGRectMake(GetWidth(10), NAVIGATION_BAR_HEIGHT, SCREENWIDTH - GetWidth(20), GetWidth(60));
        
        self.textView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), SCREENWIDTH, GetWidth(260));
    }else{
        self.textField.frame = CGRectZero;
        self.textField.hidden = YES;
        self.textView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREENWIDTH, GetWidth(260));
    }
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, 30)];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor lightGrayColor];
    self.label.text = @"这一刻你的想法....";
    [self.textView addSubview:self.label];
    
    self.pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pushBtn.frame = CGRectMake(30, CGRectGetMaxY(self.textView.frame) + 30, SCREENWIDTH - 60, 40);
    [self.pushBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.pushBtn.backgroundColor = [UIColor whiteColor];
    self.pushBtn.layer.borderColor = MAINCOLOR.CGColor;
    self.pushBtn.layer.cornerRadius = 10;
    self.pushBtn.clipsToBounds = YES;
    self.pushBtn.layer.borderWidth = 1.0f;
    [self.pushBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.pushBtn addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pushBtn];
    
    if ([self.type isEqualToString:@"发布帖子"]) {
        self.title = @"发布帖子";
    }else if ([self.type isEqualToString:@"评论"]){
        self.title = @"评论";
        self.textField.hidden = YES;
    }else if ([self.type isEqualToString:@"举报"]){
        self.title = @"举报";
        self.textField.hidden = YES;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSubViews];
}


- (void)viewDidAppear:(BOOL)animated{
    if (![self.title isEqualToString:@"举报"]) {
        [self showAlertWithTitle:@"提示" Infomation:@"1.禁止发布含有裸露、色情和亵渎的内容;\n2.禁止发布黄色、卖淫嫖娼等违法信息;\n\
         3.禁止发布政治敏感信息;\n\
         4.禁止未经他人允许随意发布他人摄影作品、文学作品，侵犯他人著作权;\n\
         5.禁止发布下流、辱骂他人、进行人身攻击的内容;\n\
         6.禁止散布谣言或未经证实的消息;\n\
         7.禁止发布广告或者灌水内容;\n\
         8.禁止发布其他违法信息;" completedAction:nil];
    }
    
}

-(void)showAlertWithTitle:(NSString *)Title Infomation:(NSString *)information completedAction:(void(^_Nullable)(UIAlertAction *action))showAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:information preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:showAction];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.label.hidden = YES;
    }else{
        self.label.hidden = NO;
    }
}

-(void)sendText{
    if ([self.title isEqualToString:@"发布帖子"]) {
        if (self.textField.text.length == 0) {
            [self showAlertWithTitle:@"提示" Infomation:@"请输入主题" completedAction:nil];
            return;
        }
        if (self.textView.text.length == 0) {
            [self showAlertWithTitle:@"提示" Infomation:@"请输入内容" completedAction:nil];
            return;
        }
        [self showAlertWithTitle:@"提示" Infomation:@"您发布的内容已提交审核，请耐心等待审核通过！" completedAction:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if ([self.title isEqualToString:@"举报"]) {
        [self showAlertWithTitle:@"提示" Infomation:@"您举报的问题，已经提交成功！" completedAction:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if([self.title isEqualToString:@"评论"]){
        if (self.textView.text.length == 0) {
            [self showAlertWithTitle:@"提示" Infomation:@"请输入内容" completedAction:nil];
            return;
        }
        [self showAlertWithTitle:@"提示" Infomation:@"您发布的评论信息已成功提交审核！" completedAction:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}



@end
