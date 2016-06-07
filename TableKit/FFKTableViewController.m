//
//  FFKTableViewController.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTableViewController.h"
#import "TableKit.h"

@interface FFKTableViewController ()

@end

@implementation FFKTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableController = [[FFKTableController alloc] initWithTableView:self.tableView];
}

@end
