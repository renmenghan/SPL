//
//  NewListModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/27.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseModel.h"
@protocol NewListModel<NSObject>

@end

@interface NewListModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *id;
@property (nonatomic,copy) NSString<Optional> *catid;
@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *title;
@property (nonatomic,copy) NSString<Optional> *read_count;
@property (nonatomic,copy) NSString<Optional> *create_time;
@property (nonatomic,copy) NSString<Optional> *catname;

@end
