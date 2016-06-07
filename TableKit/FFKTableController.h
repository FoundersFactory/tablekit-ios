//
//  FFKTableController.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFKTableController : NSObject <UITableViewDelegate, UITableViewDataSource>

/**
 The table view being managed by the controller.
 */
@property (readonly, strong) UITableView *tableView;

/**
 The sections to be displayed in the table view.
 */
@property (nonatomic, strong) NSArray *tableSections;

@property (nonatomic, strong) void (^tableViewDidScrollHandler)(UITableView *tableView, CGPoint contentOffset);

/**
 Create a new instance of a table controller with the supplied table view.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 Reloads any rows marked as dirty with the supplied animation.
 */
- (void)reloadDirtyRowsWithAnimation:(UITableViewRowAnimation)animation;


@end
