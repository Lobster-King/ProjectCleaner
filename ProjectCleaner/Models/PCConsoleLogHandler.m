//
//  PCConsoleLogHandler.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCConsoleLogHandler.h"
#import "PCUtils.h"

@implementation PCConsoleLogHandler

- (void)consoleLogInWindow:(NSTextView *)window withAttributedString:(NSAttributedString *)attributeString{
    [window.textStorage appendAttributedString:attributeString];
    [window scrollRangeToVisible:NSMakeRange([window string].length, 0)];
}

- (void)consoleLogUsingWindow:(NSTextView *)window exportToTargetDirectory:(NSString *)directoryPath{
    NSData *content = [window.string dataUsingEncoding:NSUTF8StringEncoding];
    if(!directoryPath){
        directoryPath = [[PCUtils desktopPath] stringByAppendingString:[NSString stringWithFormat:@"%@.txt",[PCUtils timeStampString]]];
    }
    [[NSFileManager defaultManager] createFileAtPath:directoryPath contents:content attributes:nil];
}

@end
