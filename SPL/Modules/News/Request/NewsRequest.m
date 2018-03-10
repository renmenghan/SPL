//
//  NewsRequest.m
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "NewsRequest.h"
#define GET_NEWS_CATS_URL                                       @"/api/v1/cat"
#define GET_NEWS_LIST_URL                                       @"/api/v1/news"
#define GET_NEWS_DETAIL_URL                                     @"/api/v1/news/"
#define GET_INDEX_DATA_URL                                      @"/api/v1/index"
#define POST_COMMENT_DATA_URL                                   @"/api/v1/comment"
#define GET_COMMENT_DATA_URL                                    @"/api/v1/comment/"
#define GET_UPVOTE_DATA_URL                                     @"/api/v1/upvote/"
#define POST_UPVOTE_URL                                         @"/api/v1/upvote"
#define POST_DEL_UPVOTE_URL                                     @"/api/v1/del_upvote"
@implementation NewsRequest

+(void)getCatsWithParams:(NSDictionary *)params success:(void (^)(NewsCatsModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_NEWS_CATS_URL parameters:params success:^(NSDictionary *result) {
        NSError *err = nil;
        NewsCatsModel *cats = [[NewsCatsModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(cats);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getNewsListWithParams:(NSDictionary *)params success:(void (^)(NewListResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_NEWS_LIST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        NewListResultModel *list = [[NewListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(list);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getNewsDetailWithParams:(NSDictionary *)params success:(void (^)(NewsDetailModel *))success failure:(void (^)(StatusModel *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",GET_NEWS_DETAIL_URL,[params objectForKey:@"newsId"]];
    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        NewsDetailModel *list = [[NewsDetailModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(list);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+(void)getCommentsDataWithParams:(NSDictionary *)params success:(void (^)(CommentsResultModel *))success failure:(void (^)(StatusModel *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",GET_COMMENT_DATA_URL,[params objectForKey:@"newsId"]];
    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        CommentsResultModel *list = [[CommentsResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(list);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getIndexDataWithParams:(NSDictionary *)params success:(void (^)(NewsIndexResultModel *))success failure:(void (^)(StatusModel *))failure
{
    
    [[TTNetworkManager sharedInstance] getWithUrl:GET_INDEX_DATA_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        NewsIndexResultModel *list = [[NewsIndexResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(list);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)postCommentDataWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:POST_COMMENT_DATA_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        
        if (failure) {
            failure(status);
        }
        
    }];
}

+ (void)getUpvoteWithParams:(NSDictionary *)params success:(void (^)(UpVoteResultModel *))success failure:(void (^)(StatusModel *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",GET_UPVOTE_DATA_URL,[params objectForKey:@"newsId"]];
    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        UpVoteResultModel *voteModel = [[UpVoteResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(voteModel);
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)postUpvoteWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(void (^)(StatusModel *))failure
{
    
    [[TTNetworkManager sharedInstance] postWithUrl:POST_UPVOTE_URL parameters:params success:^(NSDictionary *result) {
        
        
        if (success) {
            success();
        }
        
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)postUpvoteDeleteWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:POST_DEL_UPVOTE_URL parameters:params success:^(NSDictionary *result) {
        
        
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
