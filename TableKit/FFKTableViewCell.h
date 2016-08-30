//
//  FFKTableViewCell.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFKTableViewCell : UITableViewCell

/**
 Set whether a seperator should be displayed for a specific cell.
 */
@property (nonatomic, assign) BOOL seperatorsHidden;

/**
 The index path of which the cell is currently displayed at.
 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

- (void)setNeedsHeightRecalculation;

@end
