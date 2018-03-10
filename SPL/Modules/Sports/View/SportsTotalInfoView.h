//
//  SportsTotalInfoView.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/2.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportsTotaModel.h"

@interface SportsTotalInfoView : UIView
@property (nonatomic,strong) SportsTotaModel *model;
- (void)reloadData;
@end
