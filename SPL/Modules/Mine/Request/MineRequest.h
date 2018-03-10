//
//  MineRequest.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseRequest.h"
#import "UserInfoModel.h"
#import "MineChangeAvatarResultModel.h"
@interface MineRequest : BaseRequest

+(void)getUserDataWithParams:(NSDictionary *)params success:(void(^)(UserInfoModel *user))success failure:(void(^)(StatusModel *status))failure;

+ (void)postImageWithParams:(NSDictionary *)params image:(UIImage *)image success:(void(^)(MineChangeAvatarResultModel * avatar))success failure:(void(^)(StatusModel *status))failure;

+ (void)updateUserInfoWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;
@end
