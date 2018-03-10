//
//  TTNavigationController.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TTNavigationSlideBackType) {
    TTNavigationSlideBackTypeNone,
    TTNavigationSlideBackTypeEdge,
    TTNavigationSlideBackTypeScreen
};

@interface TTNavigationController : UINavigationController
@property (nonatomic, assign) TTNavigationSlideBackType slidebackType;

@end
