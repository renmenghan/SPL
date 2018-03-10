//
//  UIButton+TT.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "UIButton+TT.h"
#import "UIImage+TT.h"
#import "TTAppThemeHelper.h"

@implementation UIButton (TT)

+ (UIButton *)backButtonWithTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIImage *backImage = [UIImage imageNamed:@"btn_back" module:@"RMHBase"];
    if ([TTAppThemeHelper defaultTheme].backButtonIconName) {
        backImage = [UIImage imageNamed:[TTAppThemeHelper defaultTheme].backButtonIconName];
    }
    return [self leftBarButtonWithImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] highlightedImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] target:target action:action forControlEvents:UIControlEventTouchUpInside];
}
+ (UIButton *)leftBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0.0f, 0.0f, 44, 44);
    barButton.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [barButton addTarget:target action:action forControlEvents:controlEvents];
    [barButton setExclusiveTouch:YES];
    return barButton;
}
@end
