//
//  TTNetworkManager.m
//  RMHBase_Example
//
//  Created by 任梦晗 on 2015/12/13.
//  Copyright © 2015年 renmenghan. All rights reserved.
//

#import "TTNetworkManager.h"
#import "ShortcutMacro.h"
#import "NSMutableDictionary+NullCheck.h"
#import "ResponseModel.h"
#import "SystemMacro.h"
#import "UIDevice+TT.h"
#import "Des.h"
#import "UserService.h"
@implementation TTNetworkConfig

@end

@interface TTNetworkManager()
@property (nonatomic,copy) NSURL *baseURL;
@end

@implementation TTNetworkManager

static TTNetworkManager *_manager = nil;

+ (void)startWithConfigure:(TTNetworkConfig *)configure
{
    NSAssert(configure && configure.baseURL, @"Param can not be nil ,baseURL property os required");
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:configure.baseURL];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
        
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
        //        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
        //                                                          diskCapacity:50 * 1024 * 1024
        //                                                              diskPath:nil];
        
        //        [config setURLCache:cache];
        
        _manager = [[TTNetworkManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        
        if (configure.timeoutInterval > 0 ) {
            _manager.requestSerializer.timeoutInterval = configure.timeoutInterval;
        }
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
        [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        
    });
}

+ (TTNetworkManager *)sharedInstance
{
    if (!_manager) {
        NSLog(@"Configure TTNetwork with + startWithConfigure:first");
    }
    return _manager;
}

- (void)updateConfig
{
    if (self.currentConfig.baseURL.length > 0) {
        self.baseURL = [NSURL URLWithString:self.currentConfig.baseURL];
    }
    if (self.currentConfig.timeoutInterval > 0) {
        self.requestSerializer.timeoutInterval = self.currentConfig.timeoutInterval;
    }
}

- (void)getWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(StatusModel *))failure
{
    
    [self getWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (void)getWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSDictionary *))success failure:(void (^)(StatusModel *))failure
{
    parameters = [self addSystemParameters:parameters];
    DBG(@"GET URL:%@",URLString);
    DBG(@"Parameters:%@",parameters);
    
    NSURLSessionDataTask * task = [self GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        DBG(@"downloadProgress:%@",downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success && failure) {
            [self requestSuccess:success failure:failure data:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [self requestFailure:failure data:error];
        }
    }];
    DBG(@"Full path : %@",task.originalRequest.URL);
}

- (void)postWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(StatusModel *))failure
{
    //#ifdef DEBUG
    //    [self getWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
    //#else
    [self postWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
    //#endif
    
}

- (void)postWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSDictionary *))success failure:(void (^)(StatusModel *))failure
{
    parameters = [self addSystemParameters:parameters];
    DBG(@"POST URL:%@",URLString);
    DBG(@"Parameters:%@",parameters);
    
    [self POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        DBG(@"downloadProgress:%@",downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success && failure) {
            [self requestSuccess:success failure:failure data:responseObject];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            [self requestFailure:failure data:error];
        }
    }];
}

- (void)postFormDataWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))constructingBlock progress:(void (^)(NSProgress *))progress success:(void (^)(NSDictionary *))success failure:(void (^)(StatusModel *))failure
{
    parameters = [self addSystemParameters:parameters];
    DBG(@"POST URL:%@",URLString);
    DBG(@"Parameters:%@",parameters);
    
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (constructingBlock) {
            constructingBlock(formData);
        }
        
    } progress:^(NSProgress * _Nonnull downloadProgress) {
        
        DBG(@"downloadProgress:%@",downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success && failure) {
            [self requestSuccess:success failure:failure data:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            [self requestFailure:failure data:error];
        }
        
    }];
    
}

- (void)postImageWithUrl:(NSString *)URLString image:(UIImage *)image parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSDictionary *))success failure:(void (^)(StatusModel *))failure
{
    if (IS_IOS8) {
        parameters = [self addSystemParameters:parameters];
        DBG(@"POST URL:%@",URLString);
        DBG(@"Parameters:%@",parameters);
        
        [self postFormDataWithUrl:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            if (image) {
                NSData *data = UIImageJPEGRepresentation(image, 1);
                
                [formData appendPartWithFileData:data name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
            }
            
        } progress:^(NSProgress *uploadProgress) {
            
            DBG(@"upload Progress:%@", uploadProgress);
            if (progress) {
                progress(uploadProgress);
            }
            
        } success:^(NSDictionary *result) {
            
            if (success) {
                success(result);
            }
            
        } failure:^(StatusModel *status) {
            
            if (failure) {
                failure(status);
            }
            
        }];
    }else {
        
        parameters = [self addSystemParameters:parameters];
        DBG(@"POST URL:%@",URLString);
        DBG(@"Parameters:%@",parameters);
        
        NSString *tmpFilename = [NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]];
        NSURL *tmpFileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpFilename]];
        // Create a multipart form request.
        NSMutableURLRequest *multipartRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                                           URLString:[NSString stringWithFormat:@"%@%@",self.baseURL,URLString]
                                                                                                          parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                                                 {
                                                     
                                                     if (image) {
                                                         NSData *imageData = UIImageJPEGRepresentation(image, 1);
                                                         
                                                         [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                                                         
                                                     }
                                                     
                                                 } error:nil];
        
        [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:multipartRequest writingStreamContentsToFile:tmpFileUrl completionHandler:^(NSError * _Nullable error) {
            
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            manager.responseSerializer = self.responseSerializer;
            
            
            NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:multipartRequest fromFile:tmpFileUrl progress:progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
                // Cleanup: remove temporary file.
                [[NSFileManager defaultManager] removeItemAtURL:tmpFileUrl error:nil];
                
                if (error) {
                    if (failure) {
                        
                        [self requestFailure:failure data:error];
                        
                    }else {
                        if (success && failure) {
                            [self requestSuccess:success failure:failure data:responseObject];
                        }
                    }
                }
            }];
            
            [uploadTask resume];
            
        }];
        
    }
}


- (void)postImageWithUrl:(NSString *)URLString images:(NSArray<UIImage *> *)images parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSDictionary *))success failure:(void (^)(StatusModel *))failure
{
    if (IS_IOS8) {
        parameters = [self addSystemParameters:parameters];
        DBG(@"POST URL:%@",URLString);
        DBG(@"Parameters:%@",parameters);
        
        [self postFormDataWithUrl:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            int index = 1;
            for (UIImage *image in images ) {
                
                NSData *data = UIImageJPEGRepresentation(image, 1);
                
                [formData appendPartWithFileData:data name:@"image[]" fileName:[NSString stringWithFormat:@"image%d.jpg",index] mimeType:@"image/jpeg"];
                
                index++;
            }
            
        } progress:^(NSProgress *uploadProgress) {
            
            DBG(@"upload Progress:%@", uploadProgress);
            if (progress) {
                progress(uploadProgress);
            }
            
        } success:^(NSDictionary *result) {
            
            if (success) {
                success(result);
            }
            
        } failure:^(StatusModel *status) {
            
            if (failure) {
                failure(status);
            }
            
        }];
    }else {
        
        parameters = [self addSystemParameters:parameters];
        DBG(@"POST URL:%@",URLString);
        DBG(@"Parameters:%@",parameters);
        
        NSString *tmpFilename = [NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]];
        NSURL *tmpFileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpFilename]];
        // Create a multipart form request.
        NSMutableURLRequest *multipartRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                                           URLString:[NSString stringWithFormat:@"%@%@",self.baseURL,URLString]
                                                                                                          parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                                                 {
                                                     int index = 1;
                                                     for (UIImage *image in images) {
                                                         NSData *imageData = UIImageJPEGRepresentation(image, 1);
                                                         
                                                         [formData appendPartWithFileData:imageData name:@"image[]" fileName:[NSString stringWithFormat:@"image%d.jpg",index] mimeType:@"image/jpeg"];
                                                         index ++;
                                                     }
                                                     
                                                 } error:nil];
        
        [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:multipartRequest writingStreamContentsToFile:tmpFileUrl completionHandler:^(NSError * _Nullable error) {
            
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            manager.responseSerializer = self.responseSerializer;
            
            
            NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:multipartRequest fromFile:tmpFileUrl progress:progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
                // Cleanup: remove temporary file.
                [[NSFileManager defaultManager] removeItemAtURL:tmpFileUrl error:nil];
                
                if (error) {
                    if (failure) {
                        
                        [self requestFailure:failure data:error];
                        
                    }else {
                        if (success && failure) {
                            [self requestSuccess:success failure:failure data:responseObject];
                        }
                    }
                }
            }];
            
            [uploadTask resume];
            
        }];
        
    }
}



#pragma mark - Private Methods

- (void)requestSuccess:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure data:(id) data
{
    NSDictionary *responseDictionary = [data copy];
    
    ResponseModel *responseModel =  [[ResponseModel alloc] initWithDictionary:responseDictionary error:nil];
#pragma mark - 请求成功状态值判断
    if (responseModel && responseModel.status && 1 == responseModel.status.code) {
        if (success)
        {
            success(responseModel.result);
        }
    }else{
        
        if (responseModel && responseModel.status && 1002 == responseModel.status.code) {
            // 未登录验证
            return;
        }
        
        if (responseModel && responseModel.status && self.currentConfig.failureBLock) {
            BOOL done = self.currentConfig.failureBLock(responseModel.status.code);
            if (done) {
                return;
            }
        }
        
        if (failure) {
            if ( !responseModel || !responseModel.status) {
                
                StatusModel *status = [[StatusModel alloc] init];
                
                status.code = 404;
                status.msg = @"网络异常";
                failure(status);
                
            }else {
                
                failure(responseModel.status);
                
            }
        }
    }
    
}

- (void)requestFailure:(void(^)(StatusModel *status))failure data:(NSError *)error
{
    StatusModel *stauts = [[StatusModel alloc] init];
    stauts.code = 404;
    stauts.msg = @"网络异常";
    failure(stauts);
}

- (NSDictionary *)addSystemParameters:(NSDictionary *)parameters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 判断登录状态  添加sign
    if ([UserService sharedService].isLogin) {
        [self.requestSerializer setValue:[UserService sharedService].token forHTTPHeaderField:@"access_user_token"];
    }
    //    [params setSafeObject:@"ios" forKey:@"app_type"];
    //    [params setSafeObject:[UIDevice TT_uniqueID] forKey:@"did"];
    NSString *appType = @"ios";
    [self.requestSerializer setValue:appType forHTTPHeaderField:@"app_type"];
    NSString *did = [UIDevice TT_uniqueID];
    [self.requestSerializer setValue:did forHTTPHeaderField:@"did"];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    [self.requestSerializer setValue:[NSString stringWithFormat:@"%.0f",interval] forHTTPHeaderField:@"time"];
    [self.requestSerializer setValue:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] forHTTPHeaderField:@"version"];
    NSString *sign =[Des encryptUseDES:[NSString stringWithFormat:@"app_type=%@&did=%@&time=%.0f&version=%@",appType,did,interval,[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]] key:@"qwsxcfui"];
    
    DBG(@"sign---%@",sign);
    DBG(@"sign---%@",[Des decryptUseDES:sign key:@"qwsxcfui"]);
    
    
    [self.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    
    [params addEntriesFromDictionary:parameters];
    
    if (self.currentConfig.globalParams) {
        [params addEntriesFromDictionary:self.currentConfig.globalParams];
    }
    return params;
    
}
@end

