//
//  PCUtils.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/6.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCUtils.h"
#import <Cocoa/Cocoa.h>

static NSString *const kWindow                       = @"window";
static NSString *const kWorkspace                    = @"_workspace";
static NSString *const kParentPath                   = @"_parentPath";
static NSString *const kPathString                   = @"_pathString";
static NSString *const kRepresentingFilePath         = @"representingFilePath";
static NSString *const kIDEWorkspaceWindowController = @"IDEWorkspaceWindowController";
static NSString *const kWorkspaceWindowControllers   = @"workspaceWindowControllers";

@implementation PCUtils

+ (NSString *)projectPath{
    NSArray *workspaceWindowControllers = [NSClassFromString(kIDEWorkspaceWindowController) valueForKey:kWorkspaceWindowControllers];
    id workSpace;
    for (id controller in workspaceWindowControllers) {
        if ([[controller valueForKey:kWindow] isEqual:[NSApp keyWindow]]) {
            workSpace = [controller valueForKey:kWorkspace];
            break;
        }
    }
    NSString *workspacePath = [[[workSpace valueForKey:kRepresentingFilePath] valueForKey:kParentPath] valueForKey:kPathString];
    return workspacePath;
}

+ (NSString *)desktopPath{
    NSString *homePath = [[[NSProcessInfo processInfo] environment] objectForKey:@"HOME"];
    return [homePath stringByAppendingString:@"/Desktop/"];
}

+ (NSString *)timeStampString{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%f",interval];
}

@end
