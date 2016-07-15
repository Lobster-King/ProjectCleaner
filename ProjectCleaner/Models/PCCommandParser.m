//
//  PCCommandParser.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "PCCommandParser.h"
#import "ProjectCleaner.h"
#import "PCTaskExecuteProtocol.h"

static PCCommandParser *sharedParser = nil;
static NSString *const kPCHelpString = @"pc help";

@interface PCCommandParser()

@property (nonatomic, retain)NSDictionary *cmdMap;

@end

@implementation PCCommandParser

+ (PCCommandParser *)sharedParser{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [[PCCommandParser alloc]init];
    });
    return sharedParser;
}

- (void)consoleCmdParser:(NSString *)cmd withConsoleLog:(NSTextView *)console{
    NSString *executorName = nil;
    NSString *action = nil;
    for (NSString *name in [self.cmdMap allKeys]) {
        if ([cmd isEqualToString:name]) {
            executorName = self.cmdMap[cmd][@"executor"];
            action = self.cmdMap[cmd][@"action"];
            break;
        }
    }
    id <PCTaskExecuteProtocol>executor = [[NSClassFromString(executorName) alloc]init];
    if ([executor respondsToSelector:@selector(executeTaskWithCmd:)]) {
        if ([cmd isEqualToString:kPCHelpString]) {
            [executor executeTaskWithCmd:action,console,[self.cmdMap copy],nil];
            return;
        }
        [executor executeTaskWithCmd:action,console,nil];
    }
}

- (NSDictionary *)cmdMap{
    if (!_cmdMap) {
        _cmdMap = [NSDictionary dictionaryWithContentsOfFile:[[ProjectCleaner sharedPlugin].bundle pathForResource:@"PCCommands" ofType:@"plist"]];
    }
    return _cmdMap;
}

@end
