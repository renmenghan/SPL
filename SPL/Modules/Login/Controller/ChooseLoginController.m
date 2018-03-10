//
//  ChooseLoginController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "ChooseLoginController.h"

@interface ChooseLoginController ()
@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *thirdButton;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int page;
@end

@implementation ChooseLoginController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //取消定时器
    [self.timer invalidate];
    self.timer = nil;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //[self.timer setFireDate:[NSDate distantFuture]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self render];
    
    _page = 5;
    

    
    [self.timer fire];
}

-(void)render{
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.thirdButton];
    self.titleLabel.top = self.thirdButton.bottom + 50;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -subviews
-(UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 0, self.view.width+20, self.view.height)];
        _backgroundImageView.image = [UIImage imageNamed:@"bg5"];
    }
    
    return _backgroundImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        _titleLabel.font = FONT(15);
        _titleLabel.textColor = Color_Gray(85);
        //        _titleLabel.width = self.view.width;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"建立账户即代表您同意服务条款和隐私权政策";
    }
    return _titleLabel;
}

-(UIButton *)thirdButton
{
    if (!_thirdButton) {
        _thirdButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.center.y-40+20, self.view.width-20, 40)];
        _thirdButton.titleLabel.font = FONT(18);
        [_thirdButton setTitleColor:Color_Gray(0) forState:UIControlStateNormal];
        [_thirdButton setTitle:@"第三方登录" forState:UIControlStateNormal];
        [_thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _thirdButton.layer.borderWidth = 1;
        _thirdButton.layer.borderColor = Color_Gray(100).CGColor;
    }
    return _thirdButton;
}
-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.center.y-80, self.view.width-20, 40)];
        _loginButton.titleLabel.font = FONT(18);
        [_loginButton setTitleColor:Color_Gray(0) forState:UIControlStateNormal];
//        [_loginButton setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.58]];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.borderWidth = 1;
        _loginButton.layer.borderColor = Color_Gray(100).CGColor;
        
    }
    return _loginButton;
}

-(NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(removeImage) userInfo:nil repeats:YES];
    }
    
    return _timer;
}

- (void)removeImage
{
    if (self.backgroundImageView.left>=0) {
        _page ++;
        if (_page == 9) {
            _page = 5;
        }
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.backgroundImageView.layer addAnimation:transition forKey:@"a"];
        [self.backgroundImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg%d",_page]]];
        self.backgroundImageView.frame = CGRectMake(-20, 0, self.backgroundImageView.width, self.backgroundImageView.height);
        
        
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundImageView.frame = CGRectMake(self.backgroundImageView.left+1, 0, self.backgroundImageView.width, self.backgroundImageView.height);
    }];
}
#pragma mark -action
- (void)loginButtonClick
{
    [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"login")];
}
- (void)thirdButtonClick
{
    //[[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"chooseLogin")];
}
@end
