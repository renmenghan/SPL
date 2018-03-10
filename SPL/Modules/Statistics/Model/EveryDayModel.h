//
//  EveryDayModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/4.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>
@protocol EveryDayModel<NSObject>

@end

@interface EveryDayModel : BaseModel

@property (nonatomic,copy) NSString *time_date;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *kcl;

@end
