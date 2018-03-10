//
//  TTNavigationController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "TTNavigationController.h"

@interface TTNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation TTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //self.interactivePopGestureRecognizer.delegate = self;
        
        // 获取系统自带滑动手势的target对象
        id target = self.interactivePopGestureRecognizer.delegate;
        // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
        // 设置手势代理，拦截手势触发
        pan.delegate = self;
        
        // 给导航控制器的view添加全屏滑动手势
        [self.view addGestureRecognizer:pan];
        self.panGestureRecognizer = pan;
        
        self.slidebackType = TTNavigationSlideBackTypeNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    // fix 'nested pop animation can result in corrupted navigation bar'
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//
//    [super pushViewController:viewController animated:animated];
//}

- (void)setSlidebackType:(TTNavigationSlideBackType)slidebackType
{
    _slidebackType = slidebackType;
    if (slidebackType == TTNavigationSlideBackTypeNone) {
        self.interactivePopGestureRecognizer.enabled = NO;
        self.panGestureRecognizer.enabled = NO;
        
    }else if (slidebackType == TTNavigationSlideBackTypeEdge) {
        self.interactivePopGestureRecognizer.enabled = YES;
        self.panGestureRecognizer.enabled = NO;
        
    }else if (slidebackType == TTNavigationSlideBackTypeScreen) {
        self.interactivePopGestureRecognizer.enabled = NO;
        self.panGestureRecognizer.enabled = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer*)gestureRecognizer {
    
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if (velocity.x < 0) {
        return NO;
    }
    
    if (self.slidebackType == TTNavigationSlideBackTypeNone) {
        return NO;
    }
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.childViewControllers.count == 1)
    {
        return NO;
    }else{
        return YES;
    }
}



@end
