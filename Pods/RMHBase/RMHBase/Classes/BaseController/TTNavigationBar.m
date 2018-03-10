//
//  TTNavigationBar.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "TTNavigationBar.h"
#import "SystemMacro.h"
#import "UIView+TT.h"
#import "UIMacro.h"
#import "TTAppThemeHelper.h"

#define TAG_TITLELABEL_NAVIGATIONBAR   50000
@interface TTNavigationBar()

@property(nonatomic, strong) UIView *bottomBorder;

@end
@implementation TTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame needBlurEffect:YES];
}

- (id)initWithFrame:(CGRect)frame needBlurEffect:(BOOL)needBlurEffect
{
    self = [super initWithFrame:frame];

    if (self) {
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - (IS_IOS7 ? STATUSBAR_HEIGHT : 0))];
        self.containerView.bottom = self.height;
        needBlurEffect = NO;
        
        if (SYSTEM_VERSION >= 8.0 && needBlurEffect) {
            
            UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            
            self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            self.effectView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            self.effectView.tintColor = [UIColor whiteColor];
            [self addSubview:self.effectView];
            [self.effectView.contentView addSubview:self.containerView];
            
        }
        else
        {
            self.backgroundColor = [UIColor whiteColor];
            [self addSubview:self.containerView];
        }
        
        //描边
        self.bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.containerView.height - 1 / [UIScreen mainScreen].scale, self.containerView.width, 1 / [UIScreen mainScreen].scale)];
        self.bottomBorder.backgroundColor = [UIColor clearColor];
        [self.containerView addSubview:self.bottomBorder];
        self.containerView.bottom = self.height;
    }
    
    return self;

}
- (void)setTitle:(NSString *)title
{
    _title = title;
    if (nil == _titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((self.containerView.width - 200)/2, 0, 200, self.containerView.height)];
    }else {
        [_titleView removeAllSubviews];
    }
    _titleView.frame = CGRectMake((self.containerView.width - 200)/2, 0, 200, self.containerView.height);
    _titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, _titleView.height - 10)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [TTAppThemeHelper defaultTheme].navigationBarTitleColor;
    titleLabel.text = _title;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumScaleFactor = 14 / 18.f;
    titleLabel.tag = TAG_TITLELABEL_NAVIGATIONBAR;
    [_titleView addSubview:titleLabel];
    
    [_titleView removeFromSuperview];
    [self.containerView addSubview:_titleView];
}


- (void)setTitleColor:(UIColor*)color
{
    UILabel *titleLabel = (UILabel*)[_titleView viewWithTag:TAG_TITLELABEL_NAVIGATIONBAR];
    titleLabel.textColor = color;
}

- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    _titleView = nil;
    if (titleView) {
        _titleView = titleView;
        _titleView.center = CGPointMake(self.containerView.width / 2, self.containerView.height / 2) ;
        [self.containerView addSubview:_titleView];
    }
}

- (UILabel *)titleLabel
{
    UILabel *titleLabel = (UILabel*)[_titleView viewWithTag:TAG_TITLELABEL_NAVIGATIONBAR];
    return titleLabel;
}

- (void)setLeftBarButton:(UIView *)leftBarButton
{
    [_leftBarButton removeFromSuperview];
    _leftBarButton = nil;
    if (leftBarButton) {
        _leftBarButton = leftBarButton;
        if ([_leftBarButton isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)_leftBarButton;
            [button setTitleColor:[TTAppThemeHelper defaultTheme].navigationBarButtonColor forState:UIControlStateNormal];
            [button setTintColor:[TTAppThemeHelper defaultTheme].navigationBarButtonColor];
        }
        _leftBarButton.center = CGPointMake(_leftBarButton.width/2, self.containerView.height/2);
        [self.containerView addSubview:_leftBarButton];
    }
}

- (void)setBackBarButton:(UIView *)backBarButton
{
    [_leftBarButton removeFromSuperview];
    _leftBarButton = nil;
    if (backBarButton) {
        _leftBarButton = backBarButton;
        if ([_leftBarButton isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)_leftBarButton;
            [button setTintColor:[TTAppThemeHelper defaultTheme].navigationBarBackColor];
        }
        _leftBarButton.center = CGPointMake(_leftBarButton.width/2, self.containerView.height/2);
        [self.containerView addSubview:_leftBarButton];
    }
}

- (UIView*)backBarButton
{
    return _leftBarButton;
}

- (void)setRightBarButton:(UIView *)rightBarButton
{
    [_rightBarButton removeFromSuperview];
    _rightBarButton = nil;
    if (rightBarButton) {
        _rightBarButton = rightBarButton;
        if ([_rightBarButton isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)_rightBarButton;
            [button setTitleColor:[TTAppThemeHelper defaultTheme].navigationBarButtonColor forState:UIControlStateNormal];
            [button setTintColor:[TTAppThemeHelper defaultTheme].navigationBarButtonColor];
        }
        _rightBarButton.center = CGPointMake(self.containerView.width - (_rightBarButton.width/2) -8, self.containerView.height/2);
        [self.containerView addSubview:_rightBarButton];
        [self.containerView bringSubviewToFront:_rightBarButton];
    }
}

- (void)setBottomBorderColor:(UIColor*)color
{
    self.bottomBorder.backgroundColor = color;
}

@end
