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
    @autoreleasepool {
        NSLog(@"%s",__func__);
        NSLog(@"程序的入口 main 函数");
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
