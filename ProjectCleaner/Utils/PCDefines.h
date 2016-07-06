//
//  PCDefines.h
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/6.
//  Copyright © 2016年 lobster. All rights reserved.
//

#ifndef PCDefines_h
#define PCDefines_h

typedef NS_ENUM(NSInterger,PCTaskStatusMachine) {
    PCStatusMachineTaskStart        = 0,
    PCStatusMachineTaskExecuting    = 1,
    PCStatusMachineTaskFinished     = 2,
    PCStatusMachineTaskExecuteError = 3,
};


#endif /* PCDefines_h */
