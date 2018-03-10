//
//  TTModuleEntrance.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//
#import <UIKit/UIKit.h>
/**
 *  模块入口基类
 */
@interface TTModuleEntrance : NSObject

/**
 单例方法
 */
+ (id)sharedEntrance;

/**
 *  模块能否处理该 url
 *
 *  @param urlString url
 *  @param userInfo  附加信息
 *  @param from      来源
 *
 *  @return
 */
- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from;

/**
 *  处理传入的 url
 *
 *  @param urlString    url
 *  @param userInfo     附加信息
 *  @param from         来源
 *  @param complete     完成后的回调 block
 */
- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void(^)())complete;

#pragma mark - appdelegate notifications

/**
 *  applicationDidEnterBackground 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationDidEnterBackground:(NSNotification *)notification;

/**
 *  applicationWillEnterForeground 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationWillEnterForeground:(NSNotification *)notification;

/**
 *  applicationDidFinishLaunching 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationDidFinishLaunching:(NSNotification *)notification;

/**
 *  applicationDidBecomeActive 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationDidBecomeActive:(NSNotification *)notification;

/**
 *  applicationWillResignActive 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationWillResignActive:(NSNotification *)notification;

/**
 *  applicationDidReceiveMemoryWarning 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationDidReceiveMemoryWarning:(NSNotification *)notification;

/**
 *  applicationWillTerminate 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationWillTerminate:(NSNotification *)notification;

/**
 *  UIApplicationSignificantTimeChangeNotification 的通知方法
 *
 *  @param notification notification
 */
- (void)applicationSignificantTimeChange:(NSNotification *)notification;
@end
