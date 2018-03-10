//
//  StatisticsRequest.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/4.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>
#import "EveryDayResultModel.h"

@interface StatisticsRequest : BaseRequest

+(void)getEveryDayDataWithParams:(NSDictionary *)params success:(void(^)(EveryDayResultModel *result))success failure:(void(^)(StatusModel *status))failure;


@end
