//
//  ApplicationEntrance.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTNavigationController.h"
#import "TTTabBarController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>


extern NSString *const BaseURL;
extern NSString *const AppReceiveFamilyMessage;
extern NSString *const AppReceiveDashboardMessage;

@interface ApplicationEntrance : NSObject<TTTabbarControllerDelegate,BMKGeneralDelegate>
@property(nonatomic, strong) TTNavigationController *currentNavController;
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) TTTabBarController *tabbarController;
@property (nonatomic,strong) BMKMapManager *mapManager;


+ (ApplicationEntrance*)shareEntrance;

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions;
- (void)applicationEnterForeground;
- (void)applicationActive;
- (void)applicationEnterBackground;
- (void)handleOpenURL:(NSString *)aUrl;
- (void)applicationRegisterDeviceToken:(NSData*)deviceToken;
- (void)applicationFailToRegisterDeviceToken:(NSError*)error;
- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo;
- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)applicationHandleOpenURL:(NSURL *)url;

- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

- (TTNavigationController *)currentNavigationController;

@end
