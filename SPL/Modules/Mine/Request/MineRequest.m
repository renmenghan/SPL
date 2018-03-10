//
//  MineRequest.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "MineRequest.h"

#define GET_USER_INFO_URL           @"/api/v1/user"
#define POST_IMAGE_URL              @"/api/v1/image"
#define UPDATE_USER_INFO_URL        @"/api/v1/user"

@implementation MineRequest

+ (void)getUserDataWithParams:(NSDictionary *)params success:(void (^)(UserInfoModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_USER_INFO_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        UserInfoModel *user = [[UserInfoModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(user);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}
+ (void)postImageWithParams:(NSDictionary *)params image:(UIImage *)image success:(void (^)(MineChangeAvatarResultModel *avatar))success failure:(void (^)(StatusModel *))failure
{
    
    
    [[TTNetworkManager sharedInstance] postImageWithUrl:POST_IMAGE_URL image:image parameters:params progress:^(NSProgress *progress) {
        
    } success:^(NSDictionary *result) {
        NSError *err = nil;
        MineChangeAvatarResultModel *avatar = [[MineChangeAvatarResultModel alloc] initWithDictionary:result error:&err];
        if (success) {
            success(avatar);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)updateUserInfoWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:UPDATE_USER_INFO_URL parameters:params success:^(NSDictionary *result) {
        
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
