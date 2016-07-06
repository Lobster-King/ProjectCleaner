//
//  PCUtils.m
//  ProjectCleaner
//
//  Created by 秦志伟 on 16/7/6.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCUtils.h"
#import <Cocoa/Cocoa.h>

@implementation PCUtils

+ (NSString *)projectPath{
    NSTask *task;
    task = [[NSTask alloc] init];
    NSArray *workspaceWindowControllers = [NSClassFromString(@"IDEWorkspaceWindowController") valueForKey:@"workspaceWindowControllers"];
    
    id workSpace;
    
    for (id controller in workspaceWindowControllers) {
        if ([[controller valueForKey:@"window"] isEqual:[NSApp keyWindow]]) {
            workSpace = [controller valueForKey:@"_workspace"];
        }
    }
    
    NSString *workspacePath = [[workSpace valueForKey:@"representingFilePath"] valueForKey:@"_pathString"];
    // Set path to script
    NSString *launch_path = @"$SRCROOT/Scripts/my_script.rb";
    [task setLaunchPath:launch_path];
    return [NSString stringWithFormat:@"/Users/%@",NSUserName()];
}

@end
