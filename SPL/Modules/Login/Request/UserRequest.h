//
//  UserRequest.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/25.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseRequest.h"
#import "UserModel.h"

@interface UserRequest : BaseRequest
+ (void)getCaptchaWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

+(void)loginWithParams:(NSDictionary *)params success:(void(^)(UserModel *user))success failure:(void(^)(StatusModel *status))failure;
@end
