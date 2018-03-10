//
//  TTSliderView.m
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/14.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import "TTSliderView.h"

static NSInteger const radio = 3;

@interface TTSliderView()<UIScrollViewDelegate>
{
    NSInteger _currentPage;
    NSInteger _itemCount;
}

@property (nonatomic,strong) UIScrollView *contentView;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSMutableArray<UIImageView *> *adPics;

@property (nonatomic,strong) NSTimer *scrollTimer;
@end

@implementation TTSliderView


- (instancetype)initWithFrame:(CGRect)frame withDelete:(id)delegate
{
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = delegate;
        [self setupViews];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    
    NSInteger count = self.adPics.count;
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;

    for (int i = 0; i < count; i++) {
        UIImageView *imageView =self.adPics[i];
        imageView.frame = CGRectMake(i*width, 0, width, height);
    }
    self.contentView.contentSize = CGSizeMake(count * width, 0);
    [self scrollViewDidEndDecelerating:self.contentView];
}

- (NSTimer *)scrollTimer
{
    if (!_scrollTimer) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    }
    return _scrollTimer;
}

- (void)autoScrollNextPage
{
    NSInteger page = _currentPage + 1;
    [self.contentView setContentOffset:CGPointMake(self.contentView.frame.size.width * page, 0) animated:YES];
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.8];
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.pagingEnabled = YES;
        contentView.showsHorizontalScrollIndicator = NO;
        _contentView = contentView;
        _contentView.delegate = self;
        [self addSubview:contentView];
    }
    return _contentView;
}

- (NSMutableArray<UIImageView *> *)adPics
{
    if (!_adPics) {
        _adPics = [NSMutableArray array];
    }
    return _adPics;
}

- (void)setupViews
{
    [self.adPics makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.adPics = nil;
    
    NSInteger baseCount = [self.delegate numberOfItemsInSliderView:self];;
    _itemCount = baseCount;
    NSInteger count = baseCount;
    if (baseCount > 1) {
        count = baseCount * radio;
    }
    for (int i = 0 ; i<count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = self.adPics.count;
        
        if ([self.delegate respondsToSelector:@selector(sliderImageView:viewForItemAtIndex:)]) {
            [self.delegate sliderImageView:imageView viewForItemAtIndex:i % baseCount];
        }
        

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToLink:)];
        
        imageView.tag = i % baseCount;
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        [self.contentView addSubview:imageView];
        [self.adPics addObject:imageView];
    }
    
    self.pageControl.numberOfPages = baseCount;
    
    [self setNeedsLayout];
    
    // 定时器
    if (baseCount > 1) {
        [self.scrollTimer fire];
    }else {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

- (void)jumpToLink:(UITapGestureRecognizer *)gester{
    
    UIView *imageView = gester.view;
    NSInteger tag = imageView.tag ;
    if ([self.delegate respondsToSelector:@selector(sliderView:didSelectViewAtIndex:)]) {
        [self.delegate sliderView:self didSelectViewAtIndex:tag];
    }
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.adPics.count > 1) {
        [self scrollTimer];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
    
}
- (void)caculateCurrentPage:(UIScrollView *)scrollView
{
    if (_itemCount == 0) {
        return;
    }
    if (_itemCount == 1) {
        _currentPage = 1;

        return;
    }
    // 确认中间区域
    NSInteger min = _itemCount * (radio / 2);
    NSInteger max = _itemCount * (radio / 2 + 1);
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page % _itemCount;
    
    if (page < min || page > max) {
        page = min + page % _itemCount;
        [scrollView setContentOffset:CGPointMake(page * scrollView.frame.size.width, 0)];
    }
    
    _currentPage = page;

}
@end
