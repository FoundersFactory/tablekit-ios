//
//  FFKTableViewController.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFKTableController;

@interface FFKTableViewController : UITableViewController

/**
 The table controller managing the view.
 */
@property (readonly, strong) FFKTableController *tableController;

@end
