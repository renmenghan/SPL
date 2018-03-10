//
//  BaseViewController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseViewController.h"
#import "TTNavigationService.h"
#import "ShortcutMacro.h"
#import "UIMacro.h"
#import "UIView+TT.h"
#import "UIButton+TT.h"
#import "TTAppThemeHelper.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *noticeView;

@end

@implementation BaseViewController

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return  self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DBG(@"viewWillAppear %@", NSStringFromClass(self.class));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    DBG(@"viewWillDisappear %@", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.top = 0;
    if (!CGRectIsEmpty(_defaultFrame)) {
        self.view.frame = _defaultFrame;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needBlurEffect = YES;

//    NSLog(@"ppp");
//    self.view.backgroundColor = [UIColor redColor];
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
//    
//    btn.backgroundColor = [UIColor greenColor];
//    
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//- (void)btnClick
//{
//    [[TTNavigationService sharedService] openUrl:@"rmh://test"];
//}



#pragma mark - navigation bar

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    if (_navigationBar) {
        [_navigationBar setTitle:title];
    }
}
- (void)addNavigationBar
{
    if (!_navigationBar) {
        
        _navigationBar = [[TTNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBAR_HEIGHT) needBlurEffect:self.needBlurEffect];
        _navigationBar.backgroundColor = [TTAppThemeHelper defaultTheme].navigationBarBackgroundColor;
        _navigationBar.tintColor = [TTAppThemeHelper defaultTheme].navigationBarTintColor;
        _navigationBar.title = self.title;
    }
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1)
    {
        UIButton *backButton = [UIButton backButtonWithTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBar setBackBarButton:backButton];
    }
    
    //设置shadow色值
    [_navigationBar setBottomBorderColor:[TTAppThemeHelper defaultTheme].navigationBarBottomColor];

    
    if (!_navigationBar.superview) {
        [self.view addSubview:_navigationBar];
    }
    
}
#pragma mark - Back
- (void)clickback
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Notice view

- (void)showNotice:(NSString *)notice image:(UIImage *)image {
    [self hideNotice];
    
    _noticeView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_noticeView];
    _noticeView.userInteractionEnabled = NO;
    
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    _noticeView.customView = [[UIImageView alloc] initWithImage:image];
    
    // Set custom view mode
    _noticeView.mode = MBProgressHUDModeCustomView;
    
    //    _noticeView.yOffset = self.view.height / 3 - self.view.height / 2;
    _noticeView.centerY = self.view.centerY;
    if (notice.length > 16||[notice rangeOfString:@"\n"].location!=NSNotFound) {
        _noticeView.detailsLabelText = notice;
    }else{
        _noticeView.labelText = notice;
    }
    _noticeView.margin = 12.f;
    
    [_noticeView show:YES];
    [_noticeView hide:YES afterDelay:1.5f];
}

- (void)showNotice:(NSString *)notice {
    [self showNotice:notice image:nil];
}

- (void)showNoticeOnWindow:(NSString *)notice {
    [self showNoticeOnWindow:notice duration:0.7f];
}

- (void)showNoticeOnWindow:(NSString *)notice duration:(NSTimeInterval)duration{
    //    [self hideDefaultView];
    [self hideNotice];
    
    _noticeView = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:_noticeView];
    
    _noticeView.customView = [[UIImageView alloc] initWithImage:nil];
    // Set custom view mode
    _noticeView.mode = MBProgressHUDModeCustomView;
    
    //    _noticeView.yOffset = self.view.window.height / 3 - self.view.window.height / 2;
    _noticeView.centerY = self.view.centerY;
    if (notice.length > 16||[notice rangeOfString:@"\n"].location!=NSNotFound) {
        _noticeView.detailsLabelText = notice;
    }else{
        _noticeView.labelText = notice;
    }
    _noticeView.margin = 12.f;
    
    [_noticeView show:YES];
    [_noticeView hide:YES afterDelay:duration];
}

- (void)hideNotice {
    if (nil != _noticeView) {
        [_noticeView hide:YES afterDelay:0.f];
    }
}

@end
