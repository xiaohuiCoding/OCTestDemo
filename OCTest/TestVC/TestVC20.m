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
    
    [self testGroupNotify];
}

- (void)testGroupNotify
{
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
        
        dispatch_group_t group2 = dispatch_group_create();
        
        dispatch_group_async(group2, queue, ^{
            NSLog(@"4");
        });
        
        dispatch_group_async(group2, queue, ^{
            NSLog(@"5");
        });
    });
    
    // 输出结果是：1和2顺序不定， 3， 4或5顺序不定
}

@end
