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
#import "PCTaskStatusMachine.h"

static PCCommandParser *sharedParser = nil;
static NSString *const kPCHelpString = @"pc help";

@interface PCCommandParser()

@property (nonatomic, retain)NSDictionary *cmdMap;
@property (nonatomic, retain)NSOperationQueue *operationQueue;
@property (nonatomic, retain)PCTaskStatusMachine *statusMachine;

@end

@implementation PCCommandParser

+ (PCCommandParser *)sharedParser{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [[PCCommandParser alloc]init];
    });
    return sharedParser;
}

- (id)init{
    if (self == [super init]) {
        [self.statusMachine addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
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
    
    [self.operationQueue addOperationWithBlock:^{
        id <PCTaskExecuteProtocol>executor = [[NSClassFromString(executorName) alloc]init];
        if ([executor respondsToSelector:@selector(executeTaskWithCmd:)]) {
            if ([cmd isEqualToString:kPCHelpString]) {
                [executor executeTaskWithCmd:action,console,self.statusMachine,[self.cmdMap copy],nil];
                return;
            }
            [executor executeTaskWithCmd:action,console,self.statusMachine,nil];
        }
    }];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        int status = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        if (_delegate && [_delegate respondsToSelector:@selector(cmdExecutingStaus:)]) {
            [_delegate cmdExecutingStaus:status];
        }
    }
}

- (NSDictionary *)cmdMap{
    if (!_cmdMap) {
        _cmdMap = [NSDictionary dictionaryWithContentsOfFile:[[ProjectCleaner sharedPlugin].bundle pathForResource:@"PCCommands" ofType:@"plist"]];
    }
    return _cmdMap;
}

- (NSOperationQueue *)operationQueue{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc]init];
        _operationQueue.maxConcurrentOperationCount = 1;/*serial queue*/
    }
    return _operationQueue;
}

- (PCTaskStatusMachine *)statusMachine{
    if(!_statusMachine){
        _statusMachine = [PCTaskStatusMachine new];
    }
    return _statusMachine;
}

@end
