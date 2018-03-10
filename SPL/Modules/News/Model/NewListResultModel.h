//
//  NewListResultModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseModel.h"
#import "NewListModel.h"
#import "NewsIndexHeadModel.h"
@interface NewListResultModel : BaseModel

@property (nonatomic,assign) int total;
@property (nonatomic,assign) int page_num;
@property (nonatomic,strong) NSArray<NewListModel,Optional> *list;
@property (nonatomic,strong) NSArray<NewsIndexHeadModel,Optional> *heads;

@end
