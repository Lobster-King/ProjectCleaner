//
//  PCMainTableViewDelegate.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/6.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCMainTableViewDelegate.h"
#import "ProjectCleaner.h"

@interface PCMainTableViewDelegate()<NSTableViewDelegate,NSTableViewDataSource>

@property (nonatomic, retain)NSMutableArray *dataSource;

@end

@implementation PCMainTableViewDelegate

#pragma mark--NSTableViewDelegate--
- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn{
    NSInteger row = [tableView clickedRow];
    [tableView deselectColumn:row];
}

#pragma mark--NSTableViewDataSource--
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.dataSource.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 50.0f;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    static NSString *reuseId = @"PCTableViewCellId";
    NSTableCellView *cell = [tableView makeViewWithIdentifier:reuseId owner:self.tableViewOwner];
    if (!cell) {
        cell = [NSTableCellView new];
    }
    [cell.textField setStringValue:self.dataSource[row]];
    cell.textField.textColor = [NSColor blackColor];
    return cell;
}

#pragma mark--Getters & Setters--
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        NSDictionary *functionsName = [NSDictionary dictionaryWithContentsOfFile:[[ProjectCleaner sharedPlugin].bundle pathForResource:@"PCFuncitons" ofType:@"plist"]];
        _dataSource = [NSMutableArray arrayWithArray:functionsName[@"FunctionNames"]];
    }
    return _dataSource;
}

@end
