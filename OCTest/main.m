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
    
    NSLog(@"main() --- %f",CFAbsoluteTimeGetCurrent()); // 打印当前时间
    
    @autoreleasepool {
        NSLog(@"%s",__func__);
        
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSLog(@"当前进程的环境 --- %@", processInfo.environment);
        NSLog(@"当前进程的参数 --- %@", processInfo.arguments);
        NSLog(@"当前进程的主机名 --- %@", processInfo.hostName);
        NSLog(@"当前进程的进程名 --- %@", processInfo.processName);
        NSLog(@"当前进程的进程标识 --- %d", processInfo.processIdentifier); // PID
        NSLog(@"当前进程的唯一字符串 --- %@", processInfo.globallyUniqueString);

        NSLog(@"argc = %d argv = %s",argc,*argv); // argc的值是1，*argv的值是应用程序可执行文件的路径
        int result = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        NSLog(@"result = %d",result);
        // 这行根本不会打印！因为在 UIApplicationMain 函数的内部默认启动了一个 RunLoop，所以main函数一直不返回，这才使得程序持续运行着，并且这个默认启动的RunLoop是和主线程相关的!
        return result;
    }
}
