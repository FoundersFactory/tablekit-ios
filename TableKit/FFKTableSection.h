//
//  FFKTableSection.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFKTableInteraction;

@interface FFKTableSection : NSObject

/**
 Text to be displayed in the section header.
 */
@property (nonatomic, strong) NSString *headerText;

/**
 Text to be displayed in the section footer.
 */
@property (nonatomic, strong) NSString *footerText;

/**
 The rows to be contained within the section. Rows represent cells in the tableview.
 */
@property (nonatomic, strong) NSArray *rows;

/**
 Fired if a user performs an interaction on a cell within the section, such as a tap. Only called if the row doesn't have its own interaction handler.
 */
@property (nonatomic, strong) void (^interactionHandler)(FFKTableInteraction *interaction);

/**
 Creates a new instance of a section, and a configuration handler to set properties.
 */
+ (instancetype)tableSectionWithConfigurationHandler:(void (^)(FFKTableSection *section))handler;

@end
