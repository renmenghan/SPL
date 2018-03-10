//
//  UserService.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  下列属性被认为是通用的用户信息，应当将对应的信息存储到相应属性，确保其他module可以成功使用这些信息。
 * 非常用信息，存入extraParams。
 */
@interface UserService : NSObject
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *account;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSDictionary *extraParams;

+ (UserService *)sharedService;

//登录注册存储用户信息，应当在设置通用属性后调用该方法，确保这些信息被固化到userdefaults
- (void)saveLoginInfo;

//清除信息
- (void)clearLoginInfo;

//退出登录清除信息
- (void)logout;

//更新信息，key应当和属性名一致，value必须为NSObject类型
- (void)updateInfo:(id)value for:(NSString *)key;


@end
