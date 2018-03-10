//
//  NewsRequest.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseRequest.h"
#import "NewsCatsModel.h"
#import "NewListResultModel.h"
#import "NewsDetailModel.h"
#import "NewsIndexResultModel.h"
#import "CommentsResultModel.h"
#import "UpVoteResultModel.h"
@interface NewsRequest : BaseRequest
+(void)getCatsWithParams:(NSDictionary *)params success:(void(^)(NewsCatsModel *user))success failure:(void(^)(StatusModel *status))failure;


+(void)getNewsListWithParams:(NSDictionary *)params success:(void(^)(NewListResultModel *user))success failure:(void(^)(StatusModel *status))failure;


+(void)getNewsDetailWithParams:(NSDictionary *)params success:(void(^)(NewsDetailModel *user))success failure:(void(^)(StatusModel *status))failure;

+(void)getIndexDataWithParams:(NSDictionary *)params success:(void(^)(NewsIndexResultModel *user))success failure:(void(^)(StatusModel *status))failure;


+(void)postCommentDataWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(StatusModel *status))failure;

+(void)getCommentsDataWithParams:(NSDictionary *)params success:(void(^)(CommentsResultModel *user))success failure:(void(^)(StatusModel *status))failure;

+(void)getUpvoteWithParams:(NSDictionary *)params success:(void(^)(UpVoteResultModel * model))success failure:(void(^)(StatusModel *status))failure;


+(void)postUpvoteDeleteWithParams:(NSDictionary *)params success:(void(^)( void))success failure:(void(^)(StatusModel *status))failure;

+(void)postUpvoteWithParams:(NSDictionary *)params success:(void(^)( void))success failure:(void(^)(StatusModel *status))failure;


@end
