//
//  FFKTableRow.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTableRow.h"
#import "TableKit.h"    

@implementation FFKTableRow

+ (instancetype)tableRowWithConfigurationHandler:(void (^)(FFKTableRow *))handler
{
    FFKTableRow *row = [FFKTableRow new];
    row.cellClass = [FFKSubtitleTableViewCell class];
    handler(row);
    
    return row;
}

@end
