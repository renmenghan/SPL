//
//  NSMutableArray+NullCheck.m
//  BaseUtilityExample
//
//  Created by 任梦晗 on 17/3/14.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import "NSMutableArray+NullCheck.h"

@implementation NSMutableArray (NullCheck)
- (void)addSafeObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject) {
        [self insertObject:anObject atIndex:index];
    }
}

- (id)objectAtSafeIndex:(NSUInteger)index
{
    if (self.count > index) {
        
        return [self objectAtIndex:index];
    }
    else{
        
        return nil;
    }
}

- (void)addObjectsFromSafeArray:(NSArray *)otherArray
{
    if (otherArray && otherArray.count > 0) {
        
        [self addObjectsFromArray:otherArray];
    }
}
@end
