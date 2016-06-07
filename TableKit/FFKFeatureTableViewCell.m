//
//  FFKFeatureTableViewCell.m
//  FormKit
//
//  Created by Phillip Caudell on 06/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKFeatureTableViewCell.h"

@implementation FFKFeatureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font = [UIFont systemFontOfSize:36 weight:UIFontWeightLight];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightLight];
        self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize imageSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(self.bounds.size.width / 2 - imageSize.width / 2, 0, imageSize.width, imageSize.height);
    
    CGSize labelSize = [self.textLabel sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)];
    self.textLabel.frame = CGRectMake(self.bounds.size.width / 2 - labelSize.width / 2, self.imageView.frame.size.height, labelSize.width, labelSize.height);
    
    CGSize detailLabelSize = [self.detailTextLabel sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)];
    self.detailTextLabel.frame = CGRectMake(self.bounds.size.width / 2 - detailLabelSize.width / 2, self.textLabel.frame.size.height + self.imageView.bounds.size.height, detailLabelSize.width, detailLabelSize.height);
}

@end
