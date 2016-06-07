//
//  FFKTableViewCell.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTableViewCell.h"

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
        
        if (subview != self.contentView) {
            if (seperatorsHidden) {
                subview.alpha = 0.0;
            } else {
                subview.alpha = 1.0;
            }
        }
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.seperatorsHidden = NO;
}

@end
