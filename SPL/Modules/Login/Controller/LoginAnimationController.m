//
//  LoginAnimationController.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "LoginAnimationController.h"

@interface LoginAnimationController ()

@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *nextButton;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) NSArray *lableArr;

@end

@implementation LoginAnimationController

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
    
    _page = 1;
    
    self.lableArr = @[@"用照片记录你的生活",@"用运动填满你的人生",@"用SportsLife记录你的轨迹",@"用SportsLife记录你的轨迹"];
    
    [self.timer fire];
}

-(void)render{
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.nextButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -subviews
-(UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width+20, self.view.height)];
        _backgroundImageView.image = [UIImage imageNamed:@"bg1a"];
    }
    
    return _backgroundImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        _titleLabel.font = FONT(20);
        _titleLabel.textColor = Color_Gray(0);
//        _titleLabel.width = self.view.width;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.center = self.view.center;
        _titleLabel.text = @"用照片记录你的生活";
    }
    return _titleLabel;
}

-(UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.bottom-90, self.view.width-20, 40)];
        _nextButton.titleLabel.font = FONT(17);
        [_nextButton setTitleColor:Color_Gray(0) forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.58]];
        [_nextButton setTitle:@"继续" forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextButton;
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
    if (self.backgroundImageView.left<=-20) {
        _page ++;
        if (_page == 5) {
            _page = 1;
        }
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.backgroundImageView.layer addAnimation:transition forKey:@"a"];
        [self.backgroundImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg%da",_page]]];
        self.backgroundImageView.frame = CGRectMake(0, 0, self.backgroundImageView.width, self.backgroundImageView.height);
        
        self.titleLabel.text = self.lableArr[_page -1];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundImageView.frame = CGRectMake(self.backgroundImageView.left-1, 0, self.backgroundImageView.width,self.backgroundImageView.height);
    }];
    
}
#pragma mark -action
- (void)nextButtonClick
{
    [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"chooseLogin")];

}

@end
