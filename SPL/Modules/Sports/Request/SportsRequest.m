//
//  SportsRequest.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/3.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "SportsRequest.h"

#define GET_USER_TOTAL_SPORT_URL        @"/api/v1/sport"
#define POST_USER_TOTAL_SPORT_URL        @"/api/v1/sport"
@implementation SportsRequest

+ (void)getSportsTotalDataWithParams:(NSDictionary *)params success:(void (^)(SportsTotaModel *))success failure:(void (^)(StatusModel *))failure
{
    
    [[TTNetworkManager sharedInstance] getWithUrl:GET_USER_TOTAL_SPORT_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        SportsTotaModel *total = [[SportsTotaModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(total);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)postSportsDataWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(void (^)(StatusModel *))failure
{
    
    [[TTNetworkManager sharedInstance] postWithUrl:POST_USER_TOTAL_SPORT_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}
@end
