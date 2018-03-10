//
//  CommentsResultModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>
#import "CommentModel.h"
@interface CommentsResultModel : BaseModel
@property (nonatomic,assign) int total;
@property (nonatomic,assign) int page_num;
@property (nonatomic,strong) NSArray<CommentModel,Optional> *list;
@end
