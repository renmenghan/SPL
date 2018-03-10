//
//  VersionRequest.m
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "VersionRequest.h"
#define GET_VERSION_URL                          @"/api/v1/init"
@implementation VersionRequest

+ (void)getVersionWithParams:(NSDictionary *)params success:(void (^)(VersionResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_VERSION_URL parameters:params success:^(NSDictionary *result) {
        NSError *err = nil;
        VersionResultModel *versionModel = [[VersionResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(versionModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}
@end
