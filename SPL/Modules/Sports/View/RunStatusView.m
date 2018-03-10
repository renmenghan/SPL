//
//  RunStatusView.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/2.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "RunStatusView.h"

@interface RunStatusView()
@property (nonatomic,strong) UIButton *closeButton;

@property (nonatomic,strong) UILabel *unitKM;

@property (nonatomic,strong) UILabel *lineView;

@property (nonatomic,strong) UIButton *mapButton;

@property (nonatomic,strong) UILabel *speedLabel;

@property (nonatomic,strong) UILabel *timeLabel;


@property (nonatomic,strong) UILabel *kclLabel;

@property (nonatomic,strong) UIButton *stopButton;


@end

@implementation RunStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_Gray(0);
        self.alpha = 0.7;
        
        [self addSubview:self.closeButton];
        [self addSubview:self.distanceLabel];
        [self addSubview:self.unitKM];
        [self addSubview:self.lineView];
        [self addSubview:self.mapButton];
        
        [self addSubview:self.speedLabel];
        [self addSubview:self.speedContentLabel];
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.timeContentLabel];
        
        [self addSubview:self.kclLabel];
        [self addSubview:self.kclContentLabel];
        
        [self addSubview:self.stopButton];
    }
    
    return self;
}
#pragma mark -subviews
- (UIButton *)closeButton
{
    if (!_closeButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
        [button setBackgroundImage:[UIImage imageNamed:@"delete_post"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = button;
    }
    
    return _closeButton;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 0)];
        label.textColor = Color_White;
        label.text = @"100.00";
        label.font = BOLD_FONT(30);
        [label sizeToFit];
        label.top = 55;
        label.centerX = SCREEN_WIDTH/2;
        _distanceLabel = label;
    }
    return _distanceLabel;
}

- (UILabel *)unitKM
{
    if (!_unitKM) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = BOLD_FONT(15);
        label.text = @"KM";
        [label sizeToFit];
        label.left = self.distanceLabel.right +5;
        label.bottom = self.distanceLabel.bottom;
        _unitKM = label;
    }
    return _unitKM;
}


- (UILabel *)lineView
{
    if (!_lineView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,2)];
        label.backgroundColor = Color_White;
        label.centerY = SCREEN_HEIGHT / 2;
        _lineView = label;
    }
    return _lineView;
}

- (UIButton *)mapButton
{
    if (!_mapButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [button setImage:[UIImage imageNamed:@"mapViewImage"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mapViewClick) forControlEvents:UIControlEventTouchUpInside];
        button.center = self.lineView.center;
        _mapButton = button;
    }
    
    return _mapButton;
}

- (UIButton *)stopButton
{
    if (!_stopButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        [button setBackgroundImage:[UIImage imageNamed:@"recording_btn"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(stopClick) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"stop" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(15);
        [button setTitleColor:Color_Gray(0) forState:UIControlStateNormal];
        button.centerX = SCREEN_WIDTH /2 ;
        button.bottom = SCREEN_HEIGHT - 20;
        _stopButton = button;
    }
    
    return _stopButton;
}

- (UILabel *)speedLabel
{
    if (!_speedLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.text = @"Speed";
        [label sizeToFit];
        label.left = 25;
        label.top = self.lineView.bottom + 60;
        _speedLabel = label;
    }
    return _speedLabel;
}

- (UILabel *)speedContentLabel
{
    if (!_speedContentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.centerX = self.speedLabel.centerX;
        label.top = self.speedLabel.bottom +10;
        _speedContentLabel = label;
    }
    return _speedContentLabel;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.text = @"Time";
        [label sizeToFit];
        label.centerX = self.lineView.centerX;
        label.top = self.lineView.bottom + 60;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (MZTimerLabel *)timeContentLabel
{
    if (!_timeContentLabel) {
        MZTimerLabel *label = [[MZTimerLabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.text = @"99:99:99 ";
        label.textColor = Color_White;
        label.font = FONT(15);
        [label sizeToFit];
        label.top = self.timeLabel.bottom +10;
        label.centerX = self.timeLabel.centerX;
        _timeContentLabel = label;
    }
    return _timeContentLabel;
}

- (UILabel *)kclLabel
{
    if (!_kclLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.text = @"KCL";
        [label sizeToFit];
        
        label.right = SCREEN_WIDTH - 25;
        label.top = self.lineView.bottom + 60;
        _kclLabel = label;
    }
    return _kclLabel;
}

- (UILabel *)kclContentLabel
{
    if (!_kclContentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.top = self.kclLabel.bottom + 10;
        label.centerX = self.kclLabel.centerX;
        _kclContentLabel = label;
    }
    return _kclContentLabel;
}
#pragma mark -reloaddata
- (void)reloadData
{
   // [self.distanceLabel sizeToFit];
    
    [self.speedContentLabel sizeToFit];
    self.speedContentLabel.centerX = self.speedLabel.centerX;
    
//    [self.timeContentLabel sizeToFit];
//    self.timeContentLabel.centerX = self.timeLabel.centerX;
//
    [self.kclContentLabel sizeToFit];
    self.kclContentLabel.centerX = self.kclLabel.centerX;
}


#pragma mark -action

-(void)closeClick
{
    if ([self.delegate respondsToSelector:@selector(closeButtonClick)]) {
        [self.delegate closeButtonClick];
    }
//    [self.delegate closeButtonClick];
}
-(void)mapViewClick
{
    if ([self.delegate respondsToSelector:@selector(showMapButtonClick)]) {
        [self.delegate showMapButtonClick];
    }
}
-(void)stopClick
{
    if ([self.delegate respondsToSelector:@selector(stopButtonClick)]) {
        [self.delegate stopButtonClick];
    }
}

@end
