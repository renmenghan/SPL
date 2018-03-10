
//
//  SystemMacro.h
//  RMHBase
//
//  Created by 任梦晗 on 2015/12/13.
//  Copyright © 2015年 renmenghan. All rights reserved.
//

#ifndef SystemMacro_h
#define SystemMacro_h

#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IOS11                     (SYSTEM_VERSION >= 11)
#define IS_IOS10                     (SYSTEM_VERSION >= 10)

#define IS_IOS9                     (SYSTEM_VERSION >= 9)
#define IS_IOS8                     (SYSTEM_VERSION >= 8)
#define IS_IOS7                     (SYSTEM_VERSION >= 7)
#define IS_IPHONE4                  (SCREEN_HEIGHT < 568)
#define IS_IPHONE5                  (SCREEN_HEIGHT == 568)
#define IS_IPHONE6                  (SCREEN_HEIGHT == 667)
#define IS_IPHONE6Plus              (SCREEN_HEIGHT == 736)

#define APP_LOCAL_SCHEME @"rmh"
//标准宏
#define LOCALSCHEME(x,...)  [NSString stringWithFormat:(@"%@://" x),APP_LOCAL_SCHEME,##__VA_ARGS__]

#endif /* SystemMacro_h */
