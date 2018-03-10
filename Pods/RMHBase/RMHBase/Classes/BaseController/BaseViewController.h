//
//  BaseViewController.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTabbarItem.h"
#import "TTNavigationBar.h"

@class TTTabBarController;

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL needBlurEffect;
@property (nonatomic, strong) TTNavigationBar *navigationBar;

/**
 *  当前 ViewController 的 view 的 frame
 */
@property (nonatomic, assign) CGRect defaultFrame;

/**
 *  如果在 TTTabBarController 中使用的 TabBarItem
 */
@property (nonatomic, strong) TTTabbarItem *tabbarItem;

/**
 *  当前 viewcontroller 所在的 TTTabBarController 的引用。如果为 nil，表示不在 TTTabBarController 中。
 */
@property (nonatomic, weak) TTTabBarController *tabBarController;

- (void)clickback;
- (void)addNavigationBar;

-(void)initData;
- (void)loadData;

// Empty Tips
- (void)showEmptyTips:(NSString *)tips;
- (void)showEmptyTips:(NSString *)tips ownerView:(UIView *)ownerView;
- (void)showEmptyTips:(NSString *)tips ownerView:(UIView *)ownerView offsetTop:(CGFloat) top;
- (void)hideEmptyTips;

//网络不好的提示
- (void)showErrorTipsOnOwnerView:(UIView *)ownerView;
- (void)showErrorTips;
- (void)hideErrorTips;

// Notice
- (void)showNotice:(NSString *)notice;
- (void)showNotice:(NSString *)notice image:(UIImage *)image;
- (void)showNoticeOnWindow:(NSString *)notice;
- (void)showNoticeOnWindow:(NSString *)notice duration:(NSTimeInterval)duration;

// Alert
- (void)showAlert:(NSString *)message;

@end
