//
//  BroadcastView.m
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/14.
//  Copyright © 2020 com. All rights reserved.
//

#import "BroadcastView.h"
@interface BroadcastView ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *textLabel;
@end
@implementation BroadcastView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - self.frame.size.height/3.f)/2.f, self.frame.size.height/2.f, self.frame.size.height/2.f)];
        self.iconView.backgroundColor = [UIColor clearColor];
        self.iconView.image = [UIImage imageNamed:@"laba"];
        [self addSubview:self.iconView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconView.frame)+5, 0, self.frame.size.width - (CGRectGetMaxX(self.iconView.frame)+5), self.frame.size.height)];
        self.textLabel.textColor = [UIColor redColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
}


@end
