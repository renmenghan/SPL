//
//  NSURL+TT.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/23.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (TT)
@property (nonatomic, strong) NSDictionary *parameters;

- (NSString *)parameterForKey:(NSString *)key;
- (id)objectForKeyedSubscript:(id)key NS_AVAILABLE(10_8, 6_0);

@end
