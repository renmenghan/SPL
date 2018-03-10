//
//  TTViewPagerController.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/15.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTViewPagerBar.h"
#import "BaseViewController.h"

@interface TTViewPagerController : BaseViewController

-(void) setUpWithItems:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs;
@property (nonatomic,assign) BOOL isNav;

@property (nonatomic,strong) TTViewPagerBar *viewPagerBar;

@end
