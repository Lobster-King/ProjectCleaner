//
//  PCCommandParser.h
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSTextView;
@interface PCCommandParser : NSObject

+ (PCCommandParser *)sharedParser;

- (void)consoleCmdParser:(NSString *)cmd withConsoleLog:(NSTextView *)console;

@end
