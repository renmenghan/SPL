//
//  VersionRequest.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>
#import "VersionResultModel.h"

@interface VersionRequest : BaseRequest
+(void)getVersionWithParams:(NSDictionary *)params success:(void(^)(VersionResultModel * model))success failure:(void(^)(StatusModel *status))failure;


@end
