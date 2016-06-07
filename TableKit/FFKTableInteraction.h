//
//  FFKTableInteraction.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFKTableRow;
@class FFKTableSection;
@class FFKTableViewCell;

typedef NS_OPTIONS(NSInteger, FFKTableInteractionType) {
    FFKTableInteractionTypePrimary,
    FFKTableInteractionTypeSecondary
};

@interface FFKTableInteraction : NSObject

/**
 The row representing the cell from which the interaction originated.
 */
@property (readonly, strong) FFKTableRow *row;

/**
 The section representing the cell from which the interaction originated.
 */
@property (readonly, strong) FFKTableSection *section;

/**
 The indexPath of the cell from which the interaction originated.
 */
@property (readonly, strong) NSIndexPath *indexPath;

@property (readonly, strong) FFKTableViewCell *cell;

/**
 The type of interaction. See the enum.
 */
@property (readonly, assign) FFKTableInteractionType type;

/**
 Creates a new instance of a table interaction. You shouldn't create these directly, but rather passed them from the table controller.
 */
- (instancetype)initWithRow:(FFKTableRow *)row section:(FFKTableSection *)section indexPath:(NSIndexPath *)indexPath cell:(FFKTableViewCell *)cell type:(FFKTableInteractionType)type;

@end
