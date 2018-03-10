//
//  TTViewPagerBar.m
//  RMHBase_Example
//
//  Created by 任梦晗 on 2017/12/15.
//  Copyright © 2017年 renmenghan. All rights reserved.
//

#import "TTViewPagerBar.h"
#import "UIView+TT.h"
#define kMinMargin 30

@interface TTViewPagerBar()
{
    UIButton *_lastBtn;
}

@property (nonatomic,strong) UIScrollView *contentView;

@property (nonatomic,strong) NSMutableArray<UIButton *> *itemBtns;

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic,strong) TTViewPagerConfig *config;

@end

@implementation TTViewPagerBar

+ (instancetype)viewPagerBarWithFrame:(CGRect)frame
{
    TTViewPagerBar *viewPagerBar = [[TTViewPagerBar alloc] initWithFrame:frame];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [viewPagerBar addSubview:scrollView];
    
    viewPagerBar.contentView = scrollView;
    
    return viewPagerBar;
}

- (NSMutableArray<UIButton *> *)itemBtns
{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        CGFloat indicatorH = 2;
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-indicatorH, 0, indicatorH)];
        _indicatorView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (TTViewPagerConfig *)config
{
    if (!_config) {
        _config = [TTViewPagerConfig defaultConfig];
    }
    return _config;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count-1) {
        return;
    }
    
    _selectIndex = selectIndex;
    
    UIButton *btn = self.itemBtns[selectIndex];
    
    [self btnClick:btn];
}

-(void)btnClick:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(viewPagerBar:didSelectIndex:fromIndex:)]) {
        [self.delegate viewPagerBar:self didSelectIndex:btn.tag fromIndex:_lastBtn.tag];
    }
    
    _selectIndex = btn.tag;
    
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = btn.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    
    CGFloat scrollX = btn.centerX - (self.contentView.width / 2);
    if (scrollX < 0 ) {
        scrollX = 0;
    }
    
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    CGFloat caculateMargin = (self.width - totalBtnWidth) / (self.items.count + 1);
    if (caculateMargin < kMinMargin ) {
        caculateMargin = kMinMargin;
    }
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        btn.top = 3;
        btn.left = lastX;
        lastX += btn.width + caculateMargin;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (self.itemBtns.count == 0) {
        return;
    }
    UIButton *btn = self.itemBtns[self.selectIndex];
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.height = self.config.indicatorHeight;
    self.indicatorView.width = btn.width + self.config.indicatorExtraW *2;
    self.indicatorView.top = self.height - self.indicatorView.height;
}

- (void)updateWithConfig:(void (^)(TTViewPagerConfig *))configBlock
{
    if (configBlock) {
        configBlock(self.config);
    }
    self.backgroundColor = self.config.pagerBarBackColor;
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
    }
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    self.indicatorView.height = self.config.indicatorHeight;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
