//
//  NSView+PCUserInteraction.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "NSView+PCUserInteraction.h"

@implementation NSView (PCUserInteraction)

- (void)userinteractionDisabled{
    [self setSubviewsUserInteraction:NO];
}

- (void)userinteractionEnabled{
    [self setSubviewsUserInteraction:YES];
}

- (void)setSubviewsUserInteraction:(BOOL)isEnabled{
    NSView *obj = nil;
    NSEnumerator *enumerator = [self.subviews objectEnumerator];
    while (obj = [enumerator nextObject]) {
        if ([obj respondsToSelector:@selector(setEnabled:)]) {
            NSControl *control = (NSControl *)obj;
            [control setEnabled:isEnabled];
        }
        [obj setSubviewsUserInteraction:isEnabled];
        [obj display];
    }
}

@end
