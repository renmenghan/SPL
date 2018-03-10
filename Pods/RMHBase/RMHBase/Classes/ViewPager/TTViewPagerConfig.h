//
//  TTViewPagerConfig.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2017/12/15.
//  Copyright © 2017年 renmenghan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTViewPagerConfig : NSObject

+ (instancetype)defaultConfig;

@property (nonatomic,strong) UIColor *pagerBarBackColor;
@property (nonatomic,strong) UIColor *itemNormalColor;
@property (nonatomic,strong) UIColor *itemSelectColor;
@property (nonatomic,strong) UIFont *itemFont;
@property (nonatomic,strong) UIColor *indicatorColor;
@property (nonatomic,assign) CGFloat indicatorHeight;
@property (nonatomic,assign) CGFloat indicatorExtraW;

// titlebar background color
@property (nonatomic,copy,readonly) TTViewPagerConfig *(^p_barBackColor)(UIColor *color);
// title normal color
@property (nonatomic,copy,readonly) TTViewPagerConfig *(^p_itemNormalC)(UIColor *color);
// title select color
@property (nonatomic,copy,readonly) TTViewPagerConfig *(^p_itemSelectC)(UIColor *color);
// title font size
@property (nonatomic,copy,readonly) TTViewPagerConfig *(^p_font)(CGFloat size);
// indicator color
@property (nonatomic,copy,readonly) TTViewPagerConfig *(^p_indicatorC)(UIColor *color);
// indicator height
@property (nonatomic,copy,readonly) TTViewPagerConfig *(^p_indicatorH)(CGFloat height);
// indicator extraw width
@property (nonatomic,copy,readonly) TTViewPagerConfig *(^p_indicatorEW)(CGFloat w);


@end
