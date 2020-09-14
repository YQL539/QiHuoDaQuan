//
//  CycleScrollView.m
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/14.
//  Copyright © 2020 com. All rights reserved.
//

#import "CycleScrollView.h"
#import "BroadcastView.h"
@interface CycleScrollView ()
{
    CGRect          _topRect;
    CGRect          _middleRect;
    CGRect          _btmRect;
    NSInteger       _indexNow;
    double          _showTime;
    double          _animationTime;
    CycleScrollViewScrollDirection  _direction;
    UIButton        *_button;
    NSMutableArray  *_animationViewArray;
    NSTimer         *_timer;
    BroadcastView *_tmpAnimationView1;
    BroadcastView *_tmpAnimationView2;
    BroadcastView *_tmpTopView;
    BroadcastView *_tmpBtmView;
    BroadcastView *_tmpMiddleView;
}
@end
@implementation CycleScrollView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _showTime = 3;
        _animationTime = 0.5;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor colorWithRed:241.f/255.f green:241.f/255.f blue:241.f/255.f alpha:1.0f];
    _middleRect = self.bounds;
    _topRect = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    _btmRect = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    
    _tmpAnimationView1 = [[BroadcastView alloc] initWithFrame:_middleRect];
    [self addSubview:_tmpAnimationView1];
    
    _tmpAnimationView2 = [[BroadcastView alloc] init];
    [self addSubview:_tmpAnimationView2];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor clearColor];
    _button.frame = _middleRect;
    [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    _animationViewArray = [NSMutableArray array];
    [_animationViewArray addObject:_tmpAnimationView1];
    [_animationViewArray addObject:_tmpAnimationView2];
    self.clipsToBounds = YES;
}

- (void)configureShowTime:(double)showTime
            animationTime:(double)animationTime
                direction:(CycleScrollViewScrollDirection)direction {
    _showTime = showTime;
    _animationTime = animationTime;
    _direction = direction;
    _tmpAnimationView2.frame = _direction == CycleScrollViewScrollDirectionDown ? _topRect : _btmRect;
}

- (void)setDirection:(CycleScrollViewScrollDirection)direction{
    _direction = direction;
    _tmpAnimationView2.frame = _direction == CycleScrollViewScrollDirectionDown ? _topRect : _btmRect;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    _indexNow = 0;
    [self startAnimation];
}

- (void)startAnimation{
    [self setViewInfo];
    if (_dataSource.count > 1) {
        [self stopTimer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_showTime target:self selector:@selector(executeAnimation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)executeAnimation{
    [self setViewInfo];
    [UIView animateWithDuration:_animationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self->_tmpMiddleView.frame = self->_direction == CycleScrollViewScrollDirectionDown ? self->_btmRect : self->_topRect;
        if (self->_direction == CycleScrollViewScrollDirectionDown) {
            self->_tmpTopView.frame = self->_middleRect;
        } else {
            self->_tmpBtmView.frame = self->_middleRect;
        }
    }completion:nil];
    [self performSelector:@selector(finished)
               withObject:nil
               afterDelay:_animationTime];
    
}

- (void)finished{
    _tmpMiddleView.frame = _direction == CycleScrollViewScrollDirectionDown ? _topRect : _btmRect;
    _indexNow++;
}

- (void)setViewInfo{
    if (_direction == CycleScrollViewScrollDirectionDown) {
        if (_tmpAnimationView1.frame.origin.y == 0) {
            _tmpMiddleView = _tmpAnimationView1;
            _tmpTopView = _tmpAnimationView2;
        } else {
            _tmpMiddleView = _tmpAnimationView2;
            _tmpTopView = _tmpAnimationView1;
        }
    } else {
        if (_tmpAnimationView1.frame.origin.y == 0) {
            _tmpMiddleView = _tmpAnimationView1;
            _tmpBtmView = _tmpAnimationView2;
        } else {
            _tmpMiddleView = _tmpAnimationView2;
            _tmpBtmView = _tmpAnimationView1;
        }
    }
    _tmpMiddleView.text = _dataSource[_indexNow%(_dataSource.count)];
    if(_dataSource.count > 1){
        if (_direction == CycleScrollViewScrollDirectionDown) {
            _tmpTopView.text = _dataSource[(_indexNow+1)%(_dataSource.count)];
        } else {
            _tmpBtmView.text = _dataSource[(_indexNow+1)%(_dataSource.count)];
        }
    }
}

- (void)stopAnimation{
    [self stopTimer];
    [self.layer removeAllAnimations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)stopTimer{
    if(_timer){
        if([_timer isValid]){
            [_timer invalidate];
        }
        _timer = nil;
    }
}

- (void)btnClick{
    if(_delegate && [_delegate respondsToSelector:@selector(CycleScrollView:didClickItemIndex:)]){
        [_delegate CycleScrollView:self didClickItemIndex:_indexNow%(_dataSource.count)];
    }
}

- (void)dealloc{
    self.delegate = nil;
}

@end
