//
//  ScrollHeaderView.m
//  QiHuoDaQuan
//
//  Created by qinglong yang on 2020/9/9.
//  Copyright © 2020 Y. All rights reserved.
//

#import "ScrollHeaderView.h"
@interface ScrollHeaderView ()

@end
@implementation ScrollHeaderView

- (instancetype)initScrollViewWithTitle:(NSArray *)titleArray andRect:(CGRect)rect {
    if (self = [super initWithFrame:rect]) {
//        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
//        self.bgView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.bgView];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        CGFloat BW = 120;
        if (BW * titleArray.count < SCREENWIDTH) {
            BW = SCREENWIDTH/titleArray.count;
        }
        
        
        
        for (int i = 0 ; i < titleArray.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake(BW * i, 0, BW, rect.size.height);
            if (i == 0) {
                button.selected = YES;
                self.lastButton = button;
            }else {
                button.selected = NO;
            }
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        // 计算ScrollView的宽度，设置contentSize
        CGFloat scrollWid = CGRectGetMaxX(self.subviews.lastObject.frame);
        self.contentSize = CGSizeMake(scrollWid, rect.size.height);
        self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height - 3, BW, 3)];
        self.colorView.backgroundColor = [UIColor redColor];
        self.colorView.layer.cornerRadius = 5;
        self.colorView.layer.masksToBounds = YES;
        [self addSubview:self.colorView];
        
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
            if (self.headDelegate && [self.headDelegate respondsToSelector:@selector(didSelectItemWithIndex:)]) {
                [self.headDelegate didSelectItemWithIndex:sender.tag - 1000];
            }
        }];
    }
}


@end
