//
//  EveryDayResultModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/4.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>
#import "EveryDayModel.h"

@interface EveryDayResultModel : BaseModel

@property (nonatomic,strong) NSArray<EveryDayModel,Optional> *everyData;

@end
