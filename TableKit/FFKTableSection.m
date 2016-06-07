//
//  FFKTableSection.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTableSection.h"

@implementation FFKTableSection

+ (instancetype)tableSectionWithConfigurationHandler:(void (^)(FFKTableSection *))handler
{
    FFKTableSection *section = [FFKTableSection new];
    handler(section);
    
    return section;
}

@end
