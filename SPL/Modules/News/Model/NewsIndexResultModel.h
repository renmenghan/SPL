//
//  NewsIndexResultModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseModel.h"
#import "NewsIndexHeadModel.h"
@interface NewsIndexResultModel : BaseModel

@property (nonatomic,strong) NSArray<NewsIndexHeadModel,Optional> *heads;
@property (nonatomic,strong) NSArray<NewsIndexHeadModel,Optional> *positions;

@end
