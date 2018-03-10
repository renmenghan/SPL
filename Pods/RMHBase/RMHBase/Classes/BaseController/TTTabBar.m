//
//  TTTabBar.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "TTTabBar.h"
#import "SystemMacro.h"
#import "UIView+TT.h"
#import "UIMacro.h"
#import "TTTabbarItem.h"
#import "TTAppThemeHelper.h"

@interface TTTabBar()<TTTabbarItemDelegate>
@property(nonatomic,retain) NSMutableArray *items;
@property(nonatomic,assign) NSUInteger selectedIndex;
@property(nonatomic,retain) UIView *barPanel;
@end
@implementation TTTabBar

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<TTTabbarDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.items = [items copy];
        [self loadContent];
    }
    return self;
}

- (void)loadContent
{
    if (SYSTEM_VERSION >= 8.0) {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        effectView.tintColor = [TTAppThemeHelper defaultTheme].tabbarTintColor;
        effectView.contentView.backgroundColor = [TTAppThemeHelper defaultTheme].tabbarBackgroundColor;
        [self addSubview:effectView];
        self.barPanel = effectView.contentView;
    }
    else
    {
        self.barPanel = [[UIView alloc]initWithFrame:self.bounds];
        //self.barPanel.backgroundColor = [UIColor whiteColor];
        self.barPanel.backgroundColor = [TTAppThemeHelper defaultTheme].tabbarBackgroundColor;
        [self addSubview:self.barPanel];
    }
    
    //描边
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 1 )];
    topLine.backgroundColor = [TTAppThemeHelper defaultTheme].tabbarTopColor;
    //topLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:topLine];
    [self bringSubviewToFront:topLine];
    
    
    
    self.selectedIndex = 0;
    
    [self addItems];
}



- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.barPanel.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}


- (void)selectItemAtIndex:(NSInteger)index
{
    if (index < self.items.count) {
        [self tabBarItemdidSelected:self.items[index]];
    }
}
- (void)addItems
{
    NSUInteger barNum = self.items.count;
    CGFloat width = (self.width) / barNum;
    CGFloat xOffset = 0.0f;
    
    for (int i = 0; i < barNum; i++) {
        
        TTTabbarItem *item = self.items[i];
        item.width = width;
        item.height = self.height;
        item.left = xOffset;
        item.delegate = self;
        if (i == self.selectedIndex) {
            item.selected = YES;
        }
        item.tag = -i;
        xOffset += width;
        
        [self.barPanel addSubview:item];
        
    }
}

#pragma -mark
#pragma -mark tabbar item delegate
- (void)tabBarItemdidSelected:(TTTabbarItem *)item{
    
    NSUInteger index = -item.tag;
    
    if (index >= [self.items count]) {
        return;
    }
    
    if (self.selectedIndex != index) {
        
        BOOL shouldSelect = YES;
        if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
            shouldSelect = [self.delegate tabBar:self shouldSelectItemAtIndex:index];
        }
        
        if (!shouldSelect) {
            return;
        }
        
        TTTabbarItem *old = [self.items objectAtIndex:self.selectedIndex];
        if (old) {
            old.selected = NO;
        }
        
    }
    
    self.selectedIndex = index;
    item.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectItemAtIndex:index];
    }
}


//重写hitTest方法，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *view = [super hitTest:point withEvent:event];
        if (view) {
            return view;
        }else {
            for (UIView *subView in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [self convertPoint:point toView:subView];
                view = [subView hitTest:subPoint withEvent:event];
                if (view) {
                    return view;
                }
            }
        }
    }
    return nil;
}

@end
