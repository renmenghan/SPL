//
//  MineHeaderView.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView()

@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UILabel *usernameLabel;
@property (nonatomic,strong) UIButton *settingButton;
@property (nonatomic,strong) UILabel *signLabel;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self addSubview:self.backImageView];
        [self addSubview:self.logoImageView];
        [self addSubview:self.usernameLabel];
        [self addSubview:self.settingButton];
        [self addSubview:self.signLabel];
        
    }
    return self;
}
- (void)reloadData
{
    [self.logoImageView setOnlineImage:self.model.image];
    
    self.usernameLabel.text = self.model.username;
    [self.usernameLabel sizeToFit];
    self.usernameLabel.centerX = self.centerX;
    self.usernameLabel.top = self.logoImageView.bottom + 10;
    
    self.signLabel.text = self.model.signature;
    [self.signLabel sizeToFit];
    self.signLabel.centerX = self.centerX;
    self.signLabel.top = self.usernameLabel.bottom + 10;
    
    
}

-(UIImageView *)backImageView
{
    if (!_backImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        
        imageView.image = [UIImage imageNamed:@"listdownload"];
        _backImageView = imageView;
    }
    
    return _backImageView;
}


-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        imageView.layer.cornerRadius = 30;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.image = [UIImage imageNamed:@""];
        imageView.centerX = self.backImageView.centerX;
        imageView.centerY = self.backImageView.centerY-20;
        _logoImageView = imageView;
    }
    
    return _logoImageView;
}

-(UILabel *)usernameLabel
{
    if (!_usernameLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(17);
        label.text = @"spl001";
       
        _usernameLabel = label;
    }
    return _usernameLabel;
}

-(UILabel *)signLabel
{
    if (!_signLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.text = @"@sports";
        
        _signLabel = label;
    }
    return _signLabel;
}

- (UIButton *)settingButton
{
    if (!_settingButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        [button setImage:[UIImage imageNamed:@"addfriend"] forState:UIControlStateNormal];
        
        button.top = 10;
        button.right = SCREEN_WIDTH ;
        [button addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
        _settingButton = button;
    }
    
    return _settingButton;
}
-(void)settingClick
{
    [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"mineSetting")];
}

@end
