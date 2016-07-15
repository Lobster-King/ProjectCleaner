//
//  NSMutableString+PCSemanticParsing.m
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/15.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import "NSMutableString+PCSemanticParsing.h"

@implementation NSMutableString (PCSemanticParsing)

- (NSArray<NSString *>*)semanticParsing{
    NSArray *resultArray = [self componentsSeparatedByString:@"|"];
    if (resultArray) {
        return resultArray;
    }
    return nil;
}

@end
