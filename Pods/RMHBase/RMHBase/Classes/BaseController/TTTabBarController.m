//
//  TTTabBarController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "TTTabBarController.h"
#import "UIView+TT.h"
#import "UIMacro.h"
#import "TTTabbarItem.h"

@interface TTTabBarController ()
@property (nonatomic, strong) NSArray    *viewControllers;
@property (nonatomic, strong) NSArray *defaultViewControllers;
@property (nonatomic, strong) TTTabBar  *tabBar;
@property (nonatomic, strong) BaseViewController *selectedViewController;
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation TTTabBarController

- (id)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        self.viewControllers = viewControllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
    [self reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameWillChange:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}

- (void)reloadData
{
    NSMutableArray *itemsArray = [NSMutableArray array];

    for (BaseViewController *viewController in self.viewControllers) {
        viewController.defaultFrame = CGRectMake(0, 0, self.view.width, self.view.height - TABBAR_HEIGHT);
        
        TTTabbarItem *tabBarItem = viewController.tabbarItem;
        if (!tabBarItem) {
            tabBarItem = [[TTTabbarItem alloc] initWithTitle:viewController.title titleColor:[UIColor lightGrayColor] selectedTitleColor:nil icon:nil selectedIcon:nil];
            viewController.tabbarItem = tabBarItem;
        }
        [itemsArray addObject:tabBarItem];
        [self addChildViewController:viewController];
        viewController.tabBarController = self;
    }
    self.selectIndex = 0;
    self.selectedViewController = self.viewControllers[0];
    [self.view addSubview:[self.viewControllers[self.selectIndex] view]];
    self.tabBar = [[TTTabBar alloc] initWithFrame:CGRectMake(0, self.view.height - TABBAR_HEIGHT, self.view.width, TABBAR_HEIGHT) items:itemsArray delegate:self];
    [self.view addSubview:self.tabBar];
}

- (void)statusBarFrameWillChange:(NSNotification*)notification
{
    _tabBar.top = SCREEN_HEIGHT - TABBAR_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height + 20;
}


- (void)selectAtIndex:(NSInteger)index
{
    if (index > _viewControllers.count - 1) {
        return;
    }
    
    BaseViewController *vc = _viewControllers[index];
    
    NSInteger newIndex = 0;
    for (int i= 0; i < self.viewControllers.count; i++) {
        if ([vc isKindOfClass:[self.viewControllers[i] class]]) {
            newIndex = i;
        }
    }
    [self.tabBar selectItemAtIndex:newIndex];
    
}
#pragma mark tabbar delegate
- (void)tabBar:(TTTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index
{
    if (self.selectIndex == index) {
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarControllerWhenAppeared)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarControllerWhenAppeared) withObject:nil];
        }
    }
    else
    {
        [self.selectedViewController.view removeFromSuperview];
        
        self.selectIndex = index;
        self.selectedViewController = self.viewControllers[self.selectIndex];
        
        [self.view insertSubview:self.selectedViewController.view belowSubview:self.tabBar];
        
        if ([self.tabBarControllerDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:atIndex:)]) {
            
            [self.tabBarControllerDelegate tabBarController:self didSelectViewController:self.selectedViewController atIndex:self.selectIndex];
        }
        
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarController)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarController) withObject:nil];
        }
    }
}

- (BOOL)tabBar:(TTTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index
{
    BOOL shouldSelect = YES;
    if ([self.tabBarControllerDelegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:atIndex:)]) {
        shouldSelect = [self.tabBarControllerDelegate tabBarController:self shouldSelectViewController:self.viewControllers[index] atIndex:index];
    }
    
    return shouldSelect;
}

@end
