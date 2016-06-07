//
//  NSArray+Prototype.m
//  Prototype
//
//  Created by Phillip Caudell on 17/05/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "NSArray+FFKUtils.h"

@implementation NSArray (FFKUtils)

- (NSArray *)mapObjectsUsingBlock:(NSArrayPrototypeBlock)block
{
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [results addObject:block(obj, idx)];
    }];
    
    return results;
}


@end
