//
//  PCUtils.h
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/6.
//  Copyright © 2016年 lobster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCUtils : NSObject

/* get xcodeproj parent path,
   but bugs will be found when your xcodeproj directory was changed custom
 */
+ (NSString *)projectPath;

+ (NSString *)desktopPath;

+ (NSString *)timeStampString;

@end
