//
//  TTViewPagerConfig.m
//  RMHBase_Example
//
//  Created by 任梦晗 on 2017/12/15.
//  Copyright © 2017年 renmenghan. All rights reserved.
//

#import "TTViewPagerConfig.h"
@interface TTViewPagerConfig()


@end

@implementation TTViewPagerConfig

+ (instancetype)defaultConfig
{
    TTViewPagerConfig *config = [[TTViewPagerConfig alloc] init];
    config.pagerBarBackColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:15];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 0;
    
    return config;
}

- (TTViewPagerConfig *(^)(UIColor *))p_barBackColor
{
    return ^(UIColor *color){
        self.pagerBarBackColor = color;
        return self;
    };
}

- (TTViewPagerConfig *(^)(UIColor *))p_itemNormalC
{
    return ^(UIColor *color){
        self.itemNormalColor = color;
        return self;
    };
}

- (TTViewPagerConfig *(^)(UIColor *))p_itemSelectC
{
    return ^(UIColor *color){
        self.itemSelectColor = color;
        return self;
    };
}

- (TTViewPagerConfig *(^)(UIColor *))p_indicatorC
{
    return ^(UIColor *color){
        self.indicatorColor = color;
        return self;
    };
}

- (TTViewPagerConfig *(^)(CGFloat))p_font
{
    return ^(CGFloat size){
        self.itemFont = [UIFont systemFontOfSize:size];
        return self;
    };
}
- (TTViewPagerConfig *(^)(CGFloat))p_indicatorH
{
    return ^(CGFloat height){
        self.indicatorHeight = height;
        return self;
    };
}

- (TTViewPagerConfig *(^)(CGFloat))p_indicatorEW
{
    return ^(CGFloat w){
        self.indicatorExtraW = w;
        return self;
    };
}

@end
