//
//  PCOpenDrivingDataTaskExecutor.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/16.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCOpenDrivingDataTaskExecutor.h"
#import <Cocoa/Cocoa.h>

@implementation PCOpenDrivingDataTaskExecutor

- (void)executeTaskWithCmd:(NSString *)cmd, ...{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    [[NSWorkspace sharedWorkspace] openFile:[docDir stringByAppendingString:@"/Developer/Xcode/DerivedData/"]];
}

@end
