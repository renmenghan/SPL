//
//  StatisticsRequest.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/4.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "StatisticsRequest.h"

#define EVERY_DAY_DATA_URL           @"/api/v1/everyday"

@implementation StatisticsRequest

+ (void)getEveryDayDataWithParams:(NSDictionary *)params success:(void (^)(EveryDayResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:EVERY_DAY_DATA_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        EveryDayResultModel *user = [[EveryDayResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(user);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
