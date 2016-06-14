//
//  FFKTableController.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTableController.h"
#import "TableKit.h"    

@interface FFKTableRow (Private)

- (void)setIndexPath:(NSIndexPath *)indexPath;

@end

@interface FFKTableController ()

@property (readonly, strong) NSMutableArray *registeredCellClasses;
@property (readonly, strong) NSMutableDictionary *proxyCells;

@end

@implementation FFKTableController

- (instancetype)initWithTableView:(UITableView *)tableView
{
    if (self = [super init]) {
        
        _tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    return self;
}

- (void)setTableSections:(NSArray *)tableSections
{
    [self willChangeValueForKey:@"tableSections"];
    
    // Assign indexPaths
    [tableSections enumerateObjectsUsingBlock:^(FFKTableSection *section, NSUInteger sectionIndex, BOOL * _Nonnull stop) {
        [section.rows enumerateObjectsUsingBlock:^(FFKTableRow *row, NSUInteger rowIndex, BOOL * _Nonnull stop) {
            row.indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
        }];
    }];
    
    _tableSections = tableSections;
    
    [self didChangeValueForKey:@"tableSections"];
}

#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)idx
{
    FFKTableSection *section = self.tableSections[idx];
    
    return section.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get current row and section
    FFKTableSection *section = self.tableSections[indexPath.section];
    FFKTableRow *row = section.rows[indexPath.row];
    
    // If we haven't registered the cell, do so
    NSString *cellClassName = NSStringFromClass(row.cellClass);
    
    if (![self.registeredCellClasses containsObject:cellClassName]) {
        [self.registeredCellClasses addObject:cellClassName];
        [self.tableView registerClass:row.cellClass forCellReuseIdentifier:cellClassName];
    }
    
    FFKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(FFKTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    FFKTableSection *section = self.tableSections[indexPath.section];
    FFKTableRow *row = section.rows[indexPath.row];
    
    cell.textLabel.text = row.text;
    cell.detailTextLabel.text = row.detailText;
    cell.imageView.image = row.image;
    cell.accessoryType = row.accessoryType;
    
    if (row.cellConfigurationHandler) {
        row.cellConfigurationHandler(row, cell);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)idx
{
    FFKTableSection *section = self.tableSections[idx];
    
    return section.headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)idx
{
    FFKTableSection *section = self.tableSections[idx];
    
    return section.footerText;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFKTableSection *section = self.tableSections[indexPath.section];
    FFKTableRow *row = section.rows[indexPath.row];
    
    if (row.height > 0) {
        return row.height;
    } else {
        
        CGFloat height = [self automaticCellHeightForIndexPath:indexPath];
        
        if (height < 44) {
            height = 44;
        }
        
        return height;
    }
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFKTableSection *section = self.tableSections[indexPath.section];
    FFKTableRow *row = section.rows[indexPath.row];
    FFKTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    FFKTableInteraction *interaction = [[FFKTableInteraction alloc] initWithRow:row section:section indexPath:indexPath cell:cell type:FFKTableInteractionTypePrimary];
    
    if (row.interactionHandler) {
        return row.interactionHandler(interaction);
    }
    
    if (section.interactionHandler) {
        return section.interactionHandler(interaction);
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    FFKTableSection *section = self.tableSections[indexPath.section];
    FFKTableRow *row = section.rows[indexPath.row];
    FFKTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    FFKTableInteraction *interaction = [[FFKTableInteraction alloc] initWithRow:row section:section indexPath:indexPath cell:cell type:FFKTableInteractionTypeSecondary];
    
    if (row.interactionHandler) {
        return row.interactionHandler(interaction);
    }
    
    if (section.interactionHandler) {
        return section.interactionHandler(interaction);
    }
}

#pragma mark - Helpers

- (void)reloadDirtyRowsWithAnimation:(UITableViewRowAnimation)animation
{
    NSMutableArray *dirtyPaths = [NSMutableArray array];
    
    [self.tableSections enumerateObjectsUsingBlock:^(FFKTableSection *section, NSUInteger sectionIdx, BOOL * _Nonnull stop) {
        
        [section.rows enumerateObjectsUsingBlock:^(FFKTableRow *row, NSUInteger rowIdx, BOOL * _Nonnull stop) {
            
            if (row.isDirty) {
                [dirtyPaths addObject:[NSIndexPath indexPathForRow:rowIdx inSection:sectionIdx]];
                row.dirty = NO;
            }
        }];
    }];
    
    [self.tableView reloadRowsAtIndexPaths:dirtyPaths withRowAnimation:animation];
}

- (id)dequeueProxyCellForIndexPath:(NSIndexPath *)indexPath
{
    FFKTableSection *section = self.tableSections[indexPath.section];
    FFKTableRow *row = section.rows[indexPath.row];
    
    Class cellClass = row.cellClass;
    NSString *reuseIdentifier = NSStringFromClass(cellClass);
    id cell = self.proxyCells[reuseIdentifier];
    
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass(cellClass)];
    }
    
    return cell;
}

- (CGFloat)automaticCellHeightForIndexPath:(NSIndexPath *)indexPath
{
    // Configure a proxy instance of the row's cell
    FFKTableViewCell *proxyCell = [self dequeueProxyCellForIndexPath:indexPath];
    proxyCell.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 1);
    [self configureCell:proxyCell forIndexPath:indexPath];
    
    // Force cell to layout
    [proxyCell layoutSubviews];
    
    CGFloat height = self.tableView.rowHeight;
    CGFloat greatestY = 0;
    CGFloat lowestY = 0;
    
    // Go through each subview and find view with greatest and lowest y & height values
    for (UIView *view in proxyCell.contentView.subviews) {
        
        CGFloat maxY = view.frame.size.height + view.frame.origin.y;
        
        if (maxY > greatestY && !view.hidden) {
            greatestY = maxY;
        }
        
        if (view.frame.origin.y < lowestY) {
            lowestY = view.frame.origin.y;
        }
    }
    
    height = greatestY + fabs(lowestY);
    
    return height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableViewDidScrollHandler) {
        self.tableViewDidScrollHandler(self.tableView, scrollView.contentOffset);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    FFKTableSection *section = self.tableSections[sectionIndex];

    if (section.headerHeight == 0) {
        return UITableViewAutomaticDimension;
    } else {
        return section.headerHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    FFKTableSection *section = self.tableSections[sectionIndex];
    
    if (section.footerHeight == 0) {
        return UITableViewAutomaticDimension;
    } else {
        return section.footerHeight;
    }
}

@end
