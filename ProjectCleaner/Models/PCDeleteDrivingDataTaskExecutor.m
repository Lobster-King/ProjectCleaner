//
//  PCDeleteDrivingDataTaskExecutor.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/16.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCDeleteDrivingDataTaskExecutor.h"
#import <Cocoa/Cocoa.h>

@implementation PCDeleteDrivingDataTaskExecutor

- (void)executeTaskWithCmd:(NSString *)cmd, ...{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    [[NSFileManager defaultManager] removeItemAtPath:[docDir stringByAppendingString:@"/Developer/Xcode/DerivedData/"] error:NULL];
    
}

@end
