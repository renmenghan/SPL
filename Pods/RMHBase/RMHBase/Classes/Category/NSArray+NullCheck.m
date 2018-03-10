//
//  NullCheck.m
//  BaseUtilityExample
//
//  Created by 任梦晗 on 17/3/14.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSArray(NullCheck)

- (id)safeObjectAtIndex:(NSInteger)index
{
    id obj = nil;
    if (index < self.count) {
        obj = [self objectAtIndex:index];
    }
    return obj;
}

@end
