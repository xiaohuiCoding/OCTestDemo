//
//  main.m
//  OCTest
//
//  Created by xiaohui on 2018/1/31.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    NSLog(@"main() --- %f",CFAbsoluteTimeGetCurrent());
    
    @autoreleasepool {
        NSLog(@"%s",__func__);
        
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSLog(@"当前进程的环境 --- %@", processInfo.environment);
        NSLog(@"当前进程的参数 --- %@", processInfo.arguments);
        NSLog(@"当前进程的主机名 --- %@", processInfo.hostName);
        NSLog(@"当前进程的进程名 --- %@", processInfo.processName);
        NSLog(@"当前进程的进程标识 --- %d", processInfo.processIdentifier);
        NSLog(@"当前进程的唯一字符串 --- %@", processInfo.globallyUniqueString);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
 
