//
//  PCLogFileProtocol.h
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PCTaskExecuteProtocol <NSObject>

@required
- (void)executeTaskWithCmd:(NSString *)cmd,...NS_REQUIRES_NIL_TERMINATION;

@end
