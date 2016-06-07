//
//  FFKTableInteraction.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTableInteraction.h"

@implementation FFKTableInteraction

- (instancetype)initWithRow:(FFKTableRow *)row section:(FFKTableSection *)section indexPath:(NSIndexPath *)indexPath cell:(FFKTableViewCell *)cell type:(FFKTableInteractionType)type
{
    if (self = [super init]) {
        
        _row = row;
        _section = section;
        _indexPath = indexPath;
        _type = type;
        _cell = cell;
    }
    
    return self;
}

@end
