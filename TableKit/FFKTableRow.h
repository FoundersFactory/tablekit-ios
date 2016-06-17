//
//  FFKTableRow.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFKTableInteraction;
@class FFKTableViewCell;

@interface FFKTableRow : NSObject

/**
 The text to be displayed in the cell's textLabel.
 */
@property (nonatomic, strong) NSString *text;

/**
 The text to be displayed in the cell's detailTextLabel.
 */
@property (nonatomic, strong) NSString *detailText;

/**
 The image to be displayed in the cell's imageView.
 */
@property (nonatomic, strong) UIImage *image;

/**
 The accessory to be displayed in the cell.
 */
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

/**
 The UITableViewCell class used to represent the row in the tableview.
 */
@property (nonatomic, strong) Class cellClass;

/**
 If you need to reference back to an arbitry object that is being represented by the row, you may assign one here. 
 */
@property (nonatomic, strong) id context;

/**
 Whether the row backing the cell has changed and requires a reload.
 */
@property (nonatomic, assign, getter = isDirty) BOOL dirty;

/**
 Force cell height.
 */
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat minHeight;

@property (nonatomic, assign) UIEdgeInsets layoutMargins;

/**
 The indexPath of the row in the tableview once it has been assigned to a section.
 */
@property (readonly, strong) NSIndexPath *indexPath;

/**
 Fired if a user performs an interaction on the cell.
 */
@property (nonatomic, strong) void (^interactionHandler)(FFKTableInteraction *interaction);

/**
 Used to configure properties of the cell. This is called within cellForRowAtIndexPath.
 */
@property (nonatomic, strong) void (^cellConfigurationHandler)(FFKTableRow *row, id cell);

/**
 Creates a new instance of a table row with configuration handler to set properties.
 */
+ (instancetype)tableRowWithConfigurationHandler:(void (^)(FFKTableRow *row))handler;

@end
