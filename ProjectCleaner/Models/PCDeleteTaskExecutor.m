//
//  PCDeleteTaskExecutor.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/16.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCDeleteTaskExecutor.h"
#import <Cocoa/Cocoa.h>
#import "PCTaskStatusMachine.h"
#import "PCUtils.h"

static NSString *const kFindLaunchPath  = @"/usr/bin/find";

@interface PCDeleteTaskExecutor()

@property (nonatomic, retain)NSArray *searchOptions;
@property (nonatomic, retain)NSArray *deleteOptions;

@end

@implementation PCDeleteTaskExecutor

- (void)executeTaskWithCmd:(NSString *)cmd, ...{
    NSTextView *console = nil;
    NSDictionary *cmdMap = nil;
    PCTaskStatusMachine *task = nil;
    va_list arguments;
    va_start(arguments, cmd);
    if (cmd) {
        id param = nil;
        while ((param = va_arg(arguments, id))) {
            if ([param isKindOfClass:[NSTextView class]]) {
                console = param;
            }
            if ([param isKindOfClass:[NSDictionary class]]) {
                cmdMap = param;
            }
            if ([param isKindOfClass:[PCTaskStatusMachine class]]) {
                task = param;
            }
            if ([param isKindOfClass:[NSArray class]]) {
                self.searchOptions = param[0];
                self.deleteOptions = param[1];
            }
        }
    }
    va_end(arguments);
    
    /*logic*/
    dispatch_async(dispatch_get_main_queue(), ^{
        task.status = 0;
    });
    NSString *path = nil;
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:@"/Users/lobster/Downloads/GSD_WeiXin-master"];
    while (((path = [enumerator nextObject])))
    {
        if ([path hasSuffix:@"tx.jpeg"]) {
            NSString *deleteStringPath = [@"/Users/lobster/Downloads/GSD_WeiXin-master/" stringByAppendingString:path];
            NSString *deleteString = [NSString stringWithFormat:@"delete-->%@\n",deleteStringPath];
            dispatch_async(dispatch_get_main_queue(), ^{
                console.string = [console.string stringByAppendingString:deleteString];
                [console scrollLineDown:nil];
            });
            [[NSFileManager defaultManager] removeItemAtPath:deleteStringPath error:NULL];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        task.status = 1;
    });
    
}

@end
