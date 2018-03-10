//
//  UserModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *signature;
@property (nonatomic,copy) NSString *phone;
@end
