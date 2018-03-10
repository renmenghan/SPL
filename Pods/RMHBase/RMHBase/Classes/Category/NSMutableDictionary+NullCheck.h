//
//  NSMutableDictionary+NullCheck.h
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/13.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NullCheck)

- (void)setSafeObject:(id)anObject forKey:(id)aKey;

@end
