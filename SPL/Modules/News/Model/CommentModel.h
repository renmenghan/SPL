//
//  CommentModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/3/5.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <RMHBase/RMHBase.h>
@protocol CommentModel<NSObject>

@end
@interface CommentModel : BaseModel
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString<Optional> *to_user_id;
@property (nonatomic,copy) NSString<Optional> *content;
@property (nonatomic,copy) NSString<Optional> *username;
@property (nonatomic,copy) NSString<Optional> *tousername;
@property (nonatomic,copy) NSString<Optional> *parent_id;
@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *create_time;
@end
