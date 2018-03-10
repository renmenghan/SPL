//
//  TTViewPagerBar.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2017/12/15.
//  Copyright © 2017年 renmenghan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTViewPagerConfig.h"

@class TTViewPagerBar;

@protocol TTViewPagerBarDelegate <NSObject>

- (void)viewPagerBar:(TTViewPagerBar *)viewPagerBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface TTViewPagerBar : UIView

+ (instancetype)viewPagerBarWithFrame:(CGRect)frame;

@property (nonatomic,strong) NSArray *items;

@property (nonatomic,weak) id <TTViewPagerBarDelegate>delegate;

@property (nonatomic,assign) NSInteger selectIndex;

-(void)updateWithConfig:(void(^)(TTViewPagerConfig *config))configBlock;

@end
