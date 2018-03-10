//
//  LoginOutCell.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/2.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "LoginOutCell.h"

@interface LoginOutCell()

@property (nonatomic,strong) UIButton *logoutButton;

@end
@implementation LoginOutCell

- (void)drawCell
{
    
    [self cellAddSubView:self.logoutButton];
}

- (void)reloadData
{
    if (self.cellData) {
        
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 44;
    }
    return height;
}

- (UIButton *)logoutButton
{
    if (!_logoutButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 44)];
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        [button setBackgroundColor:Color_Gray(0)];
        [button setTitle:@"退出" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
        _logoutButton = button;
    }
    
    return _logoutButton;
}
- (void)logoutClick
{
     [[UserService sharedService] logout];
}
@end
