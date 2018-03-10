//
//  SportsTotalInfoView.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/2.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "SportsTotalInfoView.h"

@interface SportsTotalInfoView()

@property (nonatomic,strong) UILabel *totalLB;
@property (nonatomic,strong) UILabel *totalContentLB;


@property (nonatomic,strong) UILabel *totalTimeLB;
@property (nonatomic,strong) UILabel *totalTimeContentLB;

@property (nonatomic,strong) UILabel *countLb;
@property (nonatomic,strong) UILabel *countContentLB;



@end

@implementation SportsTotalInfoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.totalContentLB];
        [self addSubview:self.totalLB];
        
        [self addSubview:self.totalTimeContentLB];
        [self addSubview:self.totalTimeLB];
        
        [self addSubview:self.countContentLB];
        [self addSubview:self.countLb];
    }
    
    return self;
}

- (void)reloadData
{
    self.totalContentLB.text =[NSString stringWithFormat:@"%.2f KM",[self.model.distance floatValue]/1000] ;
    [self.totalContentLB sizeToFit];
    
    self.totalTimeContentLB.text = [NSString stringWithFormat:@"%.2fh",[self.model.time floatValue]/60.00/60.00];
    [self.totalTimeContentLB sizeToFit];
    self.totalTimeContentLB.centerX = self.totalTimeLB.centerX;
    
    self.countContentLB.text = self.model.count;
    [self.countContentLB sizeToFit];
    self.countContentLB.centerX = self.countLb.centerX;
}

-(UILabel *)totalLB
{
    if (!_totalLB) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(18);
        label.text = @"步行总距离";
        [label sizeToFit];
        label.top = self.totalContentLB.bottom+10;
        label.centerX = SCREEN_WIDTH/2;
        _totalLB = label;
    }
    return _totalLB;
}

-(UILabel *)totalContentLB
{
    if (!_totalContentLB) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = BOLD_FONT(20);
        label.text = @"00.00KM";
        [label sizeToFit];
        label.top = 50;
        label.centerX = SCREEN_WIDTH / 2;
        _totalContentLB = label;
    }
    return _totalContentLB;
}

-(UILabel *)totalTimeLB
{
    if (!_totalTimeLB) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.text = @"累积用时";
        [label sizeToFit];
        label.top = self.totalTimeContentLB.bottom + 10;
        label.centerX = self.totalTimeContentLB.centerX;
        _totalTimeLB = label;
    }
    return _totalTimeLB;
}

-(UILabel *)totalTimeContentLB
{
    if (!_totalTimeContentLB) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = BOLD_FONT(18);
        label.text = @"00.00h";
        [label sizeToFit];
        label.bottom = self.totalContentLB.bottom+ 150;
        label.left =  40;
        _totalTimeContentLB = label;
    }
    return _totalTimeContentLB;
}


-(UILabel *)countLb
{
    if (!_countLb) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = FONT(15);
        label.text = @"运动次数";
        [label sizeToFit];
        label.top = self.totalTimeContentLB.bottom + 10;
        label.centerX = self.countContentLB.centerX;
        _countLb = label;
    }
    return _countLb;
}

-(UILabel *)countContentLB
{
    if (!_countContentLB) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        label.textColor = Color_White;
        label.font = BOLD_FONT(18);
        label.text = @"0000";
        [label sizeToFit];
        label.bottom =self.totalContentLB.bottom+ 150;
        label.right = SCREEN_WIDTH - 40;
        _countContentLB = label;
    }
    return _countContentLB;
}

@end
