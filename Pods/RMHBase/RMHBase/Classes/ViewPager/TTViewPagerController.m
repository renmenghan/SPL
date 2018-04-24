//
//  TTViewPagerController.m
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/15.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import "TTViewPagerController.h"
#import "UIView+TT.h"

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define STATUSBAR_HEIGHT           (KIsiPhoneX ? 44.f :20.f)
#define NAVBAR_HEIGHT               (44.f + STATUSBAR_HEIGHT)
@interface TTViewPagerController ()<TTViewPagerBarDelegate,UIScrollViewDelegate>


@property (nonatomic,strong) UIScrollView *contentView;
@end

@implementation TTViewPagerController

-(TTViewPagerBar *)viewPagerBar
{
    if (!_viewPagerBar) {
        _viewPagerBar = [TTViewPagerBar viewPagerBarWithFrame:CGRectZero];
        _viewPagerBar.delegate = self;
        _viewPagerBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_viewPagerBar];
    }
    return _viewPagerBar;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.delegate = self;
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    self.viewPagerBar.frame = CGRectMake(0, _isNav? NAVBAR_HEIGHT : 0, self.view.width, 39);
    
    CGFloat contentViewY = self.viewPagerBar.top + self.viewPagerBar.height;
    CGRect  contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height-contentViewY);
    self.contentView.frame = contentFrame;
}

- (void)showChildVCViewsAtIndex:(NSInteger)index{
    
    if (index < 0 || index > self.childViewControllers.count - 1 || self.childViewControllers.count == 0) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:NO];
}

- (void)setUpWithItems:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs
{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"vc count not equal items");
    
    self.viewPagerBar.items = items;
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    
    self.viewPagerBar.selectIndex = 0;
}

#pragma mark -TTViewPagerBarDelegate
- (void)viewPagerBar:(TTViewPagerBar *)viewPagerBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    [self showChildVCViewsAtIndex:toIndex];
}

#pragma mark - scrollviewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    self.viewPagerBar.selectIndex = index;
}

@end

