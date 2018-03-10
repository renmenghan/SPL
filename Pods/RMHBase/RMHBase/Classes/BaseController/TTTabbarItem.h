//
//  TTTabbarItem.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TTTabbarItemDelegate;

@interface TTTabbarItem : UIControl
@property (nonatomic, weak) id<TTTabbarItemDelegate> delegate;
@property (nonatomic, assign) UIEdgeInsets imageInset;

- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon;

/**
 *  设置icon
 *
 *  @param image icon 图片
 */
- (void)setIcon:(UIImage *)image;

/**
 *  设置 selectIcon
 *
 *  @param selectedIcon 选中的 icon 图片
 */
- (void)setSelectedIcon:(UIImage *)selectedIcon;

/**
 *  设置title
 *
 *  @param title 标题
 */
-(void)setTitle:(NSString*)title;
@end

@protocol TTTabbarItemDelegate <NSObject>
@optional

/**
 *  item 被选中时调用
 *
 *  @param item 当前item
 */
- (void)tabBarItemdidSelected:(TTTabbarItem *)item;

@end
