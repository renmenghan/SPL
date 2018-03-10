//
//  UIButton+TT.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TT)
/**
 *  返回按钮
 *
 *  @param target        target
 *  @param action        action
 *  @param controlEvents UIControlEvents
 *
 *  @return button
 */
+ (UIButton *)backButtonWithTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成导航栏左侧按钮
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    UIControlEvents
 *
 *  @return button
 */
+ (UIButton *)leftBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


@end
