//
//  StatusModel.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/13.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import "BaseModel.h"

@protocol StatusModel

@end

@interface StatusModel : BaseModel

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *msg;

@end
