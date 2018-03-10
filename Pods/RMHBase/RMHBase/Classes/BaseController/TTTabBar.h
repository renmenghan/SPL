//
//  TTTabBar.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TTTabbarDelegate;

@interface TTTabBar : UIView
/**
 *  当前选中 item 的索引
 */
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
/**
 *  tabbardelegate
 */
@property (nonatomic, weak) id<TTTabbarDelegate> delegate;

/**
 *  创建 tabbar
 *
 *  @param frame    frame
 *  @param items    items 数组
 *  @param delegate delegate
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<TTTabbarDelegate>)delegate;

/**
 *  设置背景
 *
 *  @param backgroundImage 背景图
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;


/**
 *  选中某个 item
 *
 *  @param index 索引
 */
- (void)selectItemAtIndex:(NSInteger)index;

@end


@protocol TTTabbarDelegate <NSObject>

@optional

/**
 *  选中了某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 */
- (void)tabBar:(TTTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index;

/**
 *  是否能选中某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 *
 *  @return
 */
- (BOOL)tabBar:(TTTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;


@end

