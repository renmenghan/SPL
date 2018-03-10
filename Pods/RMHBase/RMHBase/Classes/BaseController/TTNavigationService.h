//
//  TTNavigationService.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTModuleEntrance.h"

#define IsEmptyString(str)      (!str || [str.trim isEqualToString : @""])

/**
 *  应用内管理跳转的服务。主要负责模块 URL 注册、分发
 */
@interface TTNavigationService : NSObject
/**
 *  navigationservice 单例
 *
 *  @return
 */
+ (TTNavigationService *)sharedService;


/**
 *  子模块 url 注册
 *
 *  @param moduleClass 子模块的类 必须为 ModuleEntrance 的子类
 *  @param scheme      url 的 scheme，不能为空
 *  @param host        url 的 host，可为空
 */
- (void)registerModule:(Class)moduleClass withScheme:(NSString *)scheme host:(NSString *)host;



/**
 *  处理 url
 *
 *  @param urlString url
 */
- (void)openUrl:(NSString *)urlString;

/**
 *  处理 url
 *
 *  @param urlString url
 *  @param userInfo  额外的 userinfo
 */
- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo;

/**
 *  处理 url
 *
 *  @param urlString url
 *  @param userInfo  额外的 userinfo
 *  @param from      来源
 *  @param complete  处理完成后调用的 block，需要各模块自行调用
 */
- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void(^)())complete;

/**
 *  是否能处理改 url
 *
 *  @param urlString url
 *  @param userInfo  额外的 userinfo
 *  @param from      来源
 *
 *  @return
 */
- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from;
@end
