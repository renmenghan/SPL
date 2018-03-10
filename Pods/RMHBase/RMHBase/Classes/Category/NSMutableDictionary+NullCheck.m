//
//  NSMutableDictionary+NullCheck.m
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/13.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import "NSMutableDictionary+NullCheck.h"

@implementation NSMutableDictionary(NullCheck)

- (void)setSafeObject:(id)anObject forKey:(id)aKey
{
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}
@end
