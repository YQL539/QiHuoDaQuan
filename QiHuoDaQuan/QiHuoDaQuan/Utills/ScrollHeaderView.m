//
//  ScrollHeaderView.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import "ScrollHeaderView.h"
@interface ScrollHeaderView ()
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *colorView;
@property (strong, nonatomic) UIButton *lastButton;
@end
@implementation ScrollHeaderView

- (instancetype)initScrollViewWithTitle:(NSArray *)titleArray andRect:(CGRect)rect {
    if (self = [super initWithFrame:rect]) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgView];
        
        CGFloat BW = rect.size.width/titleArray.count;
        self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height - 2, BW, 2)];
        self.colorView.backgroundColor = [UIColor redColor];
        self.colorView.layer.cornerRadius = 5;
        self.colorView.layer.masksToBounds = YES;
        [self.bgView addSubview:self.colorView];
        
        for (int i = 0 ; i < titleArray.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            button.backgroundColor = MAINCOLOR;
            button.frame = CGRectMake(BW * i, 0, BW, rect.size.height);
            if (i == 0) {
                button.selected = YES;
                self.lastButton = button;
            }else {
                button.selected = NO;
            }
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:button];
        }
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    if (sender != self.lastButton) {
        [UIView animateWithDuration:0.2 animations:^{
            self.colorView.x = sender.x;
        } completion:^(BOOL finished) {
            sender.selected = YES;
            self.lastButton.selected = NO;
            self.lastButton = sender;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithIndex:)]) {
                [self.delegate didSelectItemWithIndex:sender.tag - 1000];
            }
        }];
    }
}


@end
