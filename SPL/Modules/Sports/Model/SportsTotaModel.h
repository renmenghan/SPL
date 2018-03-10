//
//  SportsTotaModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/3.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>

@interface SportsTotaModel : BaseModel

@property (nonatomic,copy) NSString *distance;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString<Optional> *kcl;
@property (nonatomic,copy) NSString<Optional> *count;

@end
