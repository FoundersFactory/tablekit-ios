//
//  FFKTableViewCell.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTableViewCell.h"
#import <TableKit/TableKit.h>

@interface FFKTableViewCell ()

@end

@implementation FFKTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.numberOfLines = 0;
        self.detailTextLabel.numberOfLines = 0;
        
    }
    
    return self;
}

- (void)setSeperatorsHidden:(BOOL)seperatorsHidden
{
    for (UIView *subview in self.subviews) {
        
        // We're assuming every other subview on the cell is a seperator...¯\_(ツ)_/¯
        if (self.contentView != subview && self.backgroundView != subview && self.selectedBackgroundView != subview) {
            
            if (seperatorsHidden) {
                subview.alpha = 0.0;
            } else {
                subview.alpha = 1.0;
            }
        }
    }
    
    _seperatorsHidden = seperatorsHidden;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // A total hack. Prepare for reuse isn't called AFTER an additional dividing line has been added to the first cell in the section
    self.seperatorsHidden = _seperatorsHidden;
}



@end
