//
//  MineHeaderView.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
@interface MineHeaderView : UIView
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UserInfoModel *model;

-(void)reloadData;
@end
