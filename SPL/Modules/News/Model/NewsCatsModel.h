//
//  NewsCatsModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseModel.h"
#import "NewsCatModel.h"

@interface NewsCatsModel : BaseModel

@property (nonatomic,strong) NSArray<NewsCatModel> *cats;

@end
