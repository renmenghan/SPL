//
//  VersionResultModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>

@interface VersionResultModel : BaseModel
@property (nonatomic,copy) NSString *upgrade_point;
@property (nonatomic,copy) NSString *is_update;
@end
