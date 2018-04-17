//
//  RMHAlertView.h
//  SprotsLife
//
//  Created by liangqi on 16/11/23.
//  Copyright © 2016年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTAlertView;
@protocol TTAlertViewDelegate <NSObject>
- (void)alertView:(TTAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
@interface TTAlertView : UIView

- (instancetype)initWithTitle:(NSString *)titles andImage:(UIImage *)promptImage content:(NSString *)content cancleButton:(NSString *)cancleButton otherButtons:(NSString *)otherButtons,...
    NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use RMHAlertController instead.");


- (void)show;

@property (nonatomic,weak)id<TTAlertViewDelegate> delegate;
@end
