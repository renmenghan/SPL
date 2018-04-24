//
//  UIMacro.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h


#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height

// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width

#define TABBAR_HEIGHT               (KIsiPhoneX ? 83 :49)

#define STATUSBAR_HEIGHT            (KIsiPhoneX ? 44.f :20.f)

#define NAVBAR_HEIGHT               (44.f + STATUSBAR_HEIGHT)
#define NAVBAR_CONTAINER_HEIGHT     44.f
// viewPager tabbar 高度
#define TabsViewHeight 39
// 下单流程底部bar高度
#define TOTAL_BAR_VIEW_HEIGHT 62
#endif /* UIMacro_h */

