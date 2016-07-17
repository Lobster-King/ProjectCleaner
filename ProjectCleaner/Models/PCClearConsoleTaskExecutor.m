//
//  PCClearConsoleTaskExecutor.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/16.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCClearConsoleTaskExecutor.h"
#import <Cocoa/Cocoa.h>

@implementation PCClearConsoleTaskExecutor

- (void)executeTaskWithCmd:(NSString *)cmd, ...{
    NSTextView *console = nil;
    va_list arguments;
    va_start(arguments, cmd);
    if (cmd) {
        id param = nil;
        while ((param = va_arg(arguments, id))) {
            if ([param isKindOfClass:[NSTextView class]]) {
                console = param;
            }
        }
    }
    va_end(arguments);
    
    /*logic*/
    console.string = @"";
}

@end
