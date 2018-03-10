//
//  TTNetworkManager.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2015/12/13.
//  Copyright © 2015年 renmenghan. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "StatusModel.h"

/*
 @param TTNetworkGlobalFailureBlock 对于特定业务下通用的错误码进行处理，如果对其进行了处理，
 不再传递到下一级，即请求发起方，返回YES;如果未对其进行处理，则返回NO,由请求发起方处理。
 *  @param globalParams 所有接口都需要带的参数
 */
typedef BOOL(^TTNetworkGlobalFailureBlock)(NSInteger errorCode);

@interface TTNetworkConfig : NSObject

@property (nonatomic,strong) NSDictionary *globalParams;

@property (nonatomic,copy) NSString *baseURL;

@property (nonatomic,assign) NSTimeInterval timeoutInterval;

@property (nonatomic,copy) TTNetworkGlobalFailureBlock failureBLock;

@end

@interface TTNetworkManager : AFHTTPSessionManager

@property (nonatomic,strong,readonly) TTNetworkConfig *currentConfig;
/*
 为currentConfig设置新的值之后，调用该方法；注意：调用该方法的时候，确保前面的请求都已完成。
 */
- (void)updateConfig;

+ (void)startWithConfigure:(TTNetworkConfig *)configure;

+ (TTNetworkManager *)sharedInstance;

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void(^)(NSDictionary *result))success
           failure:(void(^)(StatusModel *status))failure;

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
          progress:(void(^)(NSProgress *))progress
           success:(void(^)(NSDictionary *result))success
           failure:(void(^)(StatusModel *status))failure;
- (void)postWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void(^)(NSDictionary *result))success
           failure:(void(^)(StatusModel *status))failure;

- (void)postWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
          progress:(void(^)(NSProgress *))progress
           success:(void(^)(NSDictionary *result))success
           failure:(void(^)(StatusModel *status))failure;

-(void)postFormDataWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
 constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))constructingBlock progress:(void(^)(NSProgress *))progress
        success:(void(^)(NSDictionary *result))success
        failure:(void(^)(StatusModel *status))failure;

- (void)postImageWithUrl:(NSString *)URLString
                   image:(UIImage *)image
              parameters:(NSDictionary *)parameters
                progress:(void(^)(NSProgress *))progress
                 success:(void(^)(NSDictionary *result))success
                 failure:(void(^)(StatusModel *status))failure;

- (void)postImageWithUrl:(NSString *)URLString
                   images:(NSArray<UIImage *>*)images
              parameters:(NSDictionary *)parameters
                progress:(void(^)(NSProgress *))progress
                 success:(void(^)(NSDictionary *result))success
                 failure:(void(^)(StatusModel *status))failure;

@end
