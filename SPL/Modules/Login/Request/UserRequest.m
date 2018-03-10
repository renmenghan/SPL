//
//  UserRequest.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/25.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "UserRequest.h"

#define USER_GET_CAPTCHA_REQUEST_URL                    @"/api/v1/identify"
#define USER_LOGIN_URL                                  @"/api/v1/login"

@implementation UserRequest


+ (void)getCaptchaWithParams:(NSDictionary *)params success:(void (^)())success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:USER_GET_CAPTCHA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        
        if (failure) {
            failure(status);
        }
    }];
}
+ (void)loginWithParams:(NSDictionary *)params success:(void (^)(UserModel *))success failure:(void (^)(StatusModel *))failure
{
    
    [[TTNetworkManager sharedInstance] postWithUrl:USER_LOGIN_URL parameters:params success:^(NSDictionary *result) {
        
      
        NSError *err = nil;
        UserModel *user = [[UserModel alloc] initWithDictionary:result error:&err];
        
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
