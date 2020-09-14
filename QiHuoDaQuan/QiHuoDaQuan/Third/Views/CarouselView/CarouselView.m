//
//  CarouselView.m
//  WaiHuiProduct
//
//  Created by qinglong yang on 2020/7/14.
//  Copyright © 2020 com. All rights reserved.
//

#import "CarouselView.h"
// 默认数量为3
static int imageViewCount = 4;
@interface CarouselView ()<UIScrollViewDelegate,CarouselViewDelegate>
/** 滚动视图 */
@property (strong, nonatomic)  UIScrollView *scrollView;
/** 页面小圆点 */
@property (strong, nonatomic)  UIPageControl *pageControll;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation CarouselView

-(void)setPagecontrollHidden:(BOOL)hidden
{
        self.pageControll.hidden = hidden;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.scrollView = [[UIScrollView alloc]init];
        [self addSubview:self.scrollView];
        
        self.pageControll = [[UIPageControl alloc]init];
        [self addSubview:self.pageControll];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControll.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    [self setupUI];
}


- (void)setupUI
{
    for (int i = 0; i < imageViewCount; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:imageView];
        // 每个IV设置点击事件
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedImageView:)];
        [imageView addGestureRecognizer:tap];
    }
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(imageViewCount * self.scrollView.frame.size.width, 0);
    // 关于pageControll的初始设置
    self.pageControll.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControll.pageIndicatorTintColor = [UIColor grayColor];
}

- (void)setImagesArr:(NSArray *)imagesArr
{
    _imagesArr = imagesArr;
    // 设置
    self.pageControll.numberOfPages = imagesArr.count;
    self.pageControll.currentPage = 0;
    // 设置内容
    [self setupContent];
    // 设置定时功能
    [self startTimer];
}

/** 这里是设置内容 */
- (void)setupContent
{
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControll.currentPage;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.pageControll.numberOfPages - 1;
        } else if (index >= self.pageControll.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
        imageView.image = self.imagesArr[index];
    }
    // 设置当前偏移量
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}

#pragma mark - 定时器

/**
 开始定时器
 */
- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

/**
 结束定时器
 */
- (void)endTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 下一页
 */
- (void)nextPage
{
    [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
    
}
#pragma mark - 自己代理调用
/**
 点击了自己图片index
 
 @param tap 点击事件
 */
- (void)clickedImageView:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    if ([self.delegate respondsToSelector:@selector(carouselView:didClickImageAtIndex:)]) {
        
        [self.delegate carouselView:self didClickImageAtIndex:imageView.tag];
    }
}
#pragma mark - 代理监听页面滚动

/**
 scrollView滚动
 
 @param scrollView 对象
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        
        distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControll.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endTimer];
}
/**
 用户拖动结束
 
 @param scrollView scrollView对象
 @param decelerate 是否完成
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

/**
 滑动结束
 
 @param scrollView scrollView对象
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setupContent];
}

/**
 滚动完成
 
 @param scrollView 对象
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self setupContent];
}

@end
