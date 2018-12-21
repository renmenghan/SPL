//
//  ApplicationEntrance.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "ApplicationEntrance.h"
#import "TTNavigationController.h"
#import "BaseViewController.h"
#import "TTTabBarController.h"
#import "TTAppThemeHelper.h"
#import "ColorMarco.h"
#import "UserService.h"
#import "TTNetworkManager.h"

#import "NewsViewPagerController.h"
#import "SportsIndexController.h"
#import "StatisticsViewController.h"
#import "MineViewController.h"


@implementation ApplicationEntrance

+ (ApplicationEntrance *)shareEntrance
{
    static ApplicationEntrance *entrance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entrance = [[ApplicationEntrance alloc] init];
    });
    
    return entrance;
}

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions
{
    self.window = mainWindow;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TTNetworkConfig *config = [[TTNetworkConfig alloc] init];
    config.baseURL = @"http://118.89.227.239:81";
    [TTNetworkManager startWithConfigure:config];
    

    // 要使用百度地图先实例化 BMKMapManager
    self.mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定 generalDelegate 参数
    BOOL ret = [self.mapManager start:@"BktFSwnXqoetK9QqkqR9kPnG2QPOinEk" generalDelegate:self];
    if (!ret) {
       DBG(@"manager start failed");
    }
   
    [self configTheme];
    
    [self initViewControllers];
}


- (void)applicationEnterForeground
{
    
}

- (void)applicationActive
{
    
}

- (void)applicationEnterBackground
{
    
}
- (void)handleOpenURL:(NSString *)aUrl
{
    
}
- (void)applicationRegisterDeviceToken:(NSData*)deviceToken
{
    
}
- (void)applicationFailToRegisterDeviceToken:(NSError*)error
{
    
}
- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo
{
    //[UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"receive:%@",userInfo);
    [self didReceiveRemoteNotification:userInfo];
}
- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    //后台点击调起应用
    
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"receive:%@",userInfo);
    //如果程序在前台，舍弃推送
    //if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
    [self didReceiveRemoteNotification:userInfo];
    //}
}
- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return NO;
}
- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}
- (BOOL)applicationHandleOpenURL:(NSURL *)url
{
    return NO;

}
- (void)didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        DBG(@"联网成功");
    }
    else{
        DBG(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        DBG(@"授权成功");
    }
    else {
        DBG(@"onGetPermissionState %d",iError);
    }
}

- (void)configTheme
{
    TTAppThemeHelper*theme = [TTAppThemeHelper defaultTheme];
    theme.mainThemeColor = [UIColor blackColor];
    theme.mainThemeContrastColor = Color_White;
    theme.navigationBarBackgroundColor = Color_Gray(0);
    theme.navigationBarTintColor = Color_White;
    theme.navigationBarBackColor = Color_White;
    theme.navigationBarButtonColor = Color_White;
    theme.navigationBarBottomColor = Color_Gray(0);
    theme.navigationBarTitleColor = Color_White;
    
    theme.tabbarBackgroundColor = Color_White;
    theme.backButtonIconName = @"arrow_back";
    theme.tabbarTopColor = Color_Gray(235);
//    theme.tabbarTintColor = Color_Red;
    //theme.checkButtonNormalIconName = @"checkbutton_normal";
    //theme.checkButtonSelectedIconName = @"checkbutton_selected";
    //theme.checkButtonDisableIconName = @"checkbutton_normal";
}

- (void)initViewControllers
{
    self.tabbarController = [[TTTabBarController alloc] initWithViewControllers:@[
                            [[NewsViewPagerController alloc] init],
                            [[SportsIndexController alloc] init],
//                            [[StatisticsViewController alloc] init],
                            [[MineViewController alloc] init],
                            ]];
    self.tabbarController.tabBarControllerDelegate = self;
    
    TTNavigationController *navigationController = [[TTNavigationController alloc] initWithRootViewController:self.tabbarController];
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    self.currentNavController = navigationController;
    
    
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    
//    [UserService sharedService].isLogin = NO;
    if (![UserService sharedService].isLogin) {
        [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"loginAnimation")];
    }
    
}
- (TTNavigationController *)currentNavigationController
{
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (self.currentNavController) {
        return self.currentNavController;
    }
    TTNavigationController *nav;
    if ([rootController isKindOfClass:[TTNavigationController class]]) {
        nav = (TTNavigationController *)rootController;
        self.currentNavController = nav;
    } else if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)rootController;
        if ([tabbarController.selectedViewController isKindOfClass:[TTNavigationController class]]) {
            nav = (TTNavigationController *)tabbarController.selectedViewController;
            self.currentNavController = nav;
        }
    }
    return nav;
}

#pragma mark - TTTabBarDelegate
- (BOOL)tabBarController:(TTTabBarController *)tabBarController shouldSelectViewController:(BaseViewController *)viewController aAPP_LOCAL_SCHEMEtIndex:(NSInteger)index
{
    //[UserService sharedService].isLogin = YES;
    if ( 0 != index && 1 != index && 2 != index&& ![UserService sharedService].isLogin ){
        [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"loginAnimation")];
        return NO;
    }
    return YES;
}

- (void)tabBarController:(TTTabBarController *)tabBarController didSelectViewController:(BaseViewController *)viewController atIndex:(NSInteger)index
{
}
@end
