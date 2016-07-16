//
//  PCCommandParser.h
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCDefines.h"

@protocol CommandParserDelegate <NSObject>

- (void)cmdExecutingStaus:(PCStatusMachine)status;

@end

@class NSTextView;
@interface PCCommandParser : NSObject

@property (nonatomic, weak)id <CommandParserDelegate>delegate;

+ (PCCommandParser *)sharedParser;

- (void)consoleCmdParser:(NSString *)cmd withConsoleLog:(NSTextView *)console;

@end
