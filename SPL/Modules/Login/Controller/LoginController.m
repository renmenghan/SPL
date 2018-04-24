//
//  LoginController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "LoginController.h"
#import "UserRequest.h"
#import "UserService.h"
typedef enum : NSUInteger {
    Code,
    Password,
} LoginType;
@interface LoginController ()

@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIButton *sendButton;
@property (nonatomic,assign) LoginType loginType;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation LoginController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addNavigationBar];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.navigationBar.rightBarButton = self.rightButton;
    
    self.title = @"登录";
    
    [self render];
    
    self.loginType = Code;
    
}

-(void)render
{
    [self.view addSubview:self.userNameTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.sendButton];
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _rightButton.titleLabel.font = FONT(14);
        [_rightButton setTitleColor:Color_White forState:UIControlStateNormal];
//        [_rightButton setBackgroundColor:Color_Gray(0)];
        [_rightButton setTitle:@"密码登录" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton sizeToFit];
        //        _loginButton.layer.borderWidth = 1;
        //        _loginButton.layer.borderColor = Color_Gray(100).CGColor;
    }
    return _rightButton;
}

- (UITextField *)userNameTF
{
    if (!_userNameTF) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, NAVBAR_HEIGHT+ 20, self.view.width-20, 44)];
        tf.font = FONT(14);
        tf.layer.borderWidth = 1;
        tf.layer.borderColor = Color_Gray(0).CGColor;
        tf.textColor = Color_Gray(0);
        tf.placeholder = @" 请输入手机号";
        tf.leftViewMode=UITextFieldViewModeAlways;
        tf.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lod_username"]];
        _userNameTF = tf;
    }
    return _userNameTF;
}

- (UITextField *)passwordTF
{
    if (!_passwordTF) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, self.userNameTF.bottom +20, (self.view.width-25)/2, 44)];
        tf.font = FONT(14);
        tf.layer.borderWidth = 1;
        tf.layer.borderColor = Color_Gray(0).CGColor;
        tf.textColor = Color_Gray(0);
        [tf setSecureTextEntry:false];
        tf.placeholder = @"请输入验证码";
        tf.leftViewMode=UITextFieldViewModeAlways;
        tf.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lod_password"]];
        _passwordTF = tf;
    }
    return _passwordTF;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.passwordTF.bottom+40, self.view.width-20, 44)];
        _loginButton.titleLabel.font = FONT(18);
        [_loginButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:Color_Gray(0)];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        _loginButton.layer.borderWidth = 1;
//        _loginButton.layer.borderColor = Color_Gray(100).CGColor;
        
    }
    return _loginButton;
}

-(UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordTF.right+10, self.userNameTF.bottom+20, (self.view.width-25)/2, 44)];
        _sendButton.titleLabel.font = FONT(14);
        [_sendButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:Color_Gray(0)];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //        _loginButton.layer.borderWidth = 1;
        //        _loginButton.layer.borderColor = Color_Gray(100).CGColor;
        
    }
    return _sendButton;
}
- (void)loginButtonClick
{
    if (IsEmptyString([self.userNameTF.text trim])) {
        [self showNotice:@"请输入手机号"];
        return;
    }
    if (IsEmptyString([self.passwordTF.text trim])) {
        [self showNotice:@"请输入验证码"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:[self.userNameTF.text trim] forKey:@"phone"];
    if (self.loginType == Password) {
         [params setSafeObject:[[self.passwordTF.text trim] md5] forKey:@"password"];
    }else if (self.loginType == Code){
        [params setSafeObject:[self.passwordTF.text trim] forKey:@"code"];
    }
    
    
    [UserRequest loginWithParams:params success:^(UserModel *user) {
        
        [UserService sharedService].token = user.token;
        [UserService sharedService].isLogin = YES;
        [[UserService sharedService] saveLoginInfo];
        
        [self.navigationController popToRootViewControllerAnimated: YES];
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
        
    }];
}
- (void)sendButtonClick
{
    NSString *phoneText = self.userNameTF.text;
    if (IsEmptyString(phoneText)) {
        
        [self showNotice:@"请输入手机号"];
        return;
    }
    NSDictionary *params = @{@"id":phoneText};
    
    [self setCaptchaButtonEnabled:NO];
    __weak typeof(self) weakSelf = self;
    [UserRequest getCaptchaWithParams:params success:^{
        weakSelf.time = 60;
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        [weakSelf.timer fire];
        
    } failure:^(StatusModel *status) {
       [weakSelf setCaptchaButtonEnabled:YES];
        [weakSelf showNotice:status.msg];
    }];
    
    
    
}
-(void)rightButtonClick
{
    self.passwordTF.text = @"";
    if (self.loginType == Code) {
        self.loginType =Password;
        self.passwordTF.placeholder = @"请输入密码";
        [self.passwordTF setSecureTextEntry:true];
        self.passwordTF.width = self.view.width - 20;
        self.sendButton.hidden = YES;
    }else{
        self.loginType =Code;
        self.passwordTF.placeholder = @"请输入验证码";
        [self.passwordTF setSecureTextEntry:false];
        self.passwordTF.width = (self.view.width-25)/2;
        self.sendButton.hidden = NO;

    }
}

- (void)setCaptchaButtonEnabled: (BOOL)enabled {
    
    if ( enabled ) {
        self.sendButton.enabled = YES;
        self.sendButton.backgroundColor = Color_Gray(0);
    } else {
        self.sendButton.enabled = NO;
        self.sendButton.backgroundColor = Color_Gray(235);
    }
    
}

- (void)handleTimer
{
    if (self.time <= 1) {
        [self.timer invalidate];
        [self setCaptchaButtonEnabled:YES];
        [_sendButton setTitle:@"重发验证码" forState:UIControlStateNormal];
        return;
    }
    
    [self.sendButton setTitle:[NSString stringWithFormat:@"%lds", (long)self.time] forState:UIControlStateDisabled];
    self.time--;
}

@end
