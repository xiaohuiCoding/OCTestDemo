//
//  TestVC28.m
//  OCTest

//  Crash解析（二）iOS系统级别的策略

//  Created by Apple on 2021/10/27.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC28.h"

/*
 参考：
 原理分析：https://www.cnblogs.com/lxmtx/p/12368543.html
         https://www.jianshu.com/p/33ee5e7d312c
 instrument的使用：https://www.jianshu.com/p/4d94a700de96
                 http://www.cocoachina.com/articles/20334
 */

@interface TestVC28 ()

@end

@implementation TestVC28

static NSMutableArray *testArray;
char *buffer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 200, 100, 40);
    [button setTitle:@"野指针" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(200, 200, 100, 40);
    [button2 setTitle:@"堆缓冲区溢出" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(rightBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

    testArray = [[NSMutableArray alloc] initWithCapacity:5];
    [testArray release]; // 释放对象(.m文件已改为MRC机制)
    
    /*
     1.全局设置工程MRC/ARC
     选中 Target， 在 Objective C language 地方，将 ARC 设为 YES 或 NO。
     2.设置单个文件MRC/ARC
     在targets的build phases选项下Compile Sources下选择是否使用arc编译的文件，双击后输入：
     -fno-objc-arc ： MRC
     -fobjc-arc ：ARC
     */
}

- (void)leftBtnEvent {
    /* 1.访问野指针 导致的crash(可使用NSZombie Objects的方式调试，Xcode勾选，然后在Product -> Scheme -> Edit Scheme -> Arguments设置NSZombieEnabled、MallocStackLoggingNoCompact两个变量，且值均为YES）
     Thread 1: EXC_BREAKPOINT (code=1, subcode=0x1bf50810c)
     控制台报错：*** -[__NSArrayM addObject:]: message sent to deallocated instance 0x600003468810
     */
    [testArray addObject:@2];
}

- (void)rightBtnEvent {
    /* 2.堆缓冲区溢出 导致的crash(可使用Address Sanitizer的方式调试，Xcode勾选)
     Thread 1: Heap buffer overflow
     */
    unsigned size = 5;
    buffer = malloc(size);
    sprintf(buffer, "Hello");
    NSLog(@"%p, %s", buffer, buffer);
}

@end
