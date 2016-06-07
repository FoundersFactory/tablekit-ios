//
//  NSArray+Prototype.h
//  Prototype
//
//  Created by Phillip Caudell on 17/05/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^NSArrayPrototypeBlock)(id object, NSInteger idx);

@interface NSArray (FFKUtils)

/**
 Maps each object in the array using a block.
 */
- (NSArray *)mapObjectsUsingBlock:(NSArrayPrototypeBlock)block;

@end
