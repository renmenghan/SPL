//
//  RunStatusView.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/2.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"



@protocol RunStatusViewDelegate<NSObject>

-(void)closeButtonClick;
-(void)showMapButtonClick;
-(void)stopButtonClick;
@end

@interface RunStatusView : UIView

@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) MZTimerLabel *timeContentLabel;
@property (nonatomic,strong) UILabel *speedContentLabel;
@property (nonatomic,strong) UILabel *kclContentLabel;

@property (nonatomic,weak) id <RunStatusViewDelegate> delegate;


-(void)reloadData;
@end
