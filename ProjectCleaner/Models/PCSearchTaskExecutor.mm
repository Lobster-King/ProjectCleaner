//
//  PCSearchTaskExecutor.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/16.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCSearchTaskExecutor.h"
#import <Cocoa/Cocoa.h>
#import "PCTaskStatusMachine.h"
#import "PCUtils.h"
#include "PCTextHelper.hpp"

@interface PCSearchTaskExecutor()

@property (nonatomic, retain)NSArray *searchOptions;
@property (nonatomic, retain)NSArray *unusedOptions;

@end

@implementation PCSearchTaskExecutor

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
                self.unusedOptions = param[1];
            }
        }
    }
    va_end(arguments);
    
    /*logic*/
    dispatch_async(dispatch_get_main_queue(), ^{
        task.status = PCStatusMachineTaskExecuting;
    });
    
    NSString *path = nil;
    NSString *dirtory = [PCUtils projectPath];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirtory];
    
    NSMutableArray *imagePathArray = [NSMutableArray new];
    NSMutableArray *searchPathArray= [NSMutableArray new];
    while (((path = [enumerator nextObject])))
    {
        NSString *searchStringPath = [dirtory stringByAppendingString:@"/"];
        searchStringPath = [searchStringPath stringByAppendingString:path];
        for (NSString *reg in self.unusedOptions) {
            if ([searchStringPath hasSuffix:reg]) {
                [imagePathArray addObject:searchStringPath];
            }
        }
        
        for (NSString *reg in self.searchOptions) {
            if ([searchStringPath hasSuffix:reg]) {
                [searchPathArray addObject:searchStringPath];
            }
        }
    }
    
    for (NSString *imagePath in imagePathArray) {
        NSString *relativeImageName = [imagePath lastPathComponent];
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[_-].*\\d.*.png" options:NSRegularExpressionCaseInsensitive error:nil];
        NSString *newImageName = [regular stringByReplacingMatchesInString:relativeImageName options:NSMatchingReportProgress range:NSMakeRange(0, [relativeImageName length]) withTemplate:@""];
        if (newImageName) {
            relativeImageName = newImageName;
        }
        
        NSArray *imageNameArray = nil;
        imageNameArray = [relativeImageName componentsSeparatedByString:@"@3x."];
        if (imageNameArray.count <= 1) {
            imageNameArray = [relativeImageName componentsSeparatedByString:@"@2x."];
            if (imageNameArray.count <= 1) {
                imageNameArray = [relativeImageName componentsSeparatedByString:@"."];
            }
        }
        relativeImageName = imageNameArray[0];
        BOOL isIn = NO;
        
        for (NSString *searchPath in searchPathArray) {
            if (isTextInFile([searchPath UTF8String], [relativeImageName UTF8String])) {
                isIn = YES;
                break;
            }
        }
        
        if (!isIn) {
            NSString *searchString = [NSString stringWithFormat:@"search-->%@\n",imagePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:searchString];
                [console.textStorage appendAttributedString:attributedString];
                [console scrollRangeToVisible:NSMakeRange([[console string] length],0)];
            });
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        task.status = PCStatusMachineTaskFinished;
    });
}

@end
