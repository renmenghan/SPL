//
//  SportsRequest.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/3.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>
#import "SportsTotaModel.h"

@interface SportsRequest : BaseRequest

+ (void)getSportsTotalDataWithParams:(NSDictionary *)params success:(void(^)(SportsTotaModel * total))success failure:(void(^)(StatusModel *status))failure;

+ (void)postSportsDataWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

@end
