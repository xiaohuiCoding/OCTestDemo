//
//  TestVC20.m
//  OCTest

//  串行与并行

//  Created by xiaohui on 2018/8/21.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC20.h"

@interface TestVC20 ()

@end

@implementation TestVC20

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testGroupNotifyQueue];
//    [self testSerialSyncQueue];
    [self testSerialSyncInCustomQueue];
//    [self testParallelSyncInGlobalQueue];
    
}

- (void)testGroupNotify {
    //GCD实现1，2并行和3串行和45串行，4，5是并行。即3依赖1，2的执行，45依赖3的执行。
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_group_async(group, queue, ^{
        NSLog(@"1");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"2");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"3");
        
        dispatch_group_t groupNew = dispatch_group_create();
        
        dispatch_group_async(groupNew, queue, ^{
            NSLog(@"4");
        });
        
        dispatch_group_async(groupNew, queue, ^{
            NSLog(@"5");
        });
    });
}

//串行同步
- (void)testSerialSyncInMainQueue {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"1---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"4---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"5---%@",[NSThread currentThread]);
        });
    });
}

//串行同步
- (void)testSerialSyncInCustomQueue {
    dispatch_queue_t queue = dispatch_queue_create("com.xiaohui.666666", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"1---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"2---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"3---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"4---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"5---%@",[NSThread currentThread]);
        });
    });
}

//并行同步
- (void)testParallelSyncInGlobalQueue {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"1---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"2---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"3---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"4---%@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"5---%@",[NSThread currentThread]);
        });
    });
}


@end
