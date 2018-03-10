//
//  NewsIndexHeadModel.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/28.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import "BaseModel.h"

@protocol NewsIndexHeadModel<NSObject>

@end

@interface NewsIndexHeadModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *id;
@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *title;
@property (nonatomic,copy) NSString<Optional> *read_count;


@end
