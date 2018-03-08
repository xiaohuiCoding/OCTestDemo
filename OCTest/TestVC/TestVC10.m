//
//  TestVC10.m
//  OCTest

//  RunLoop（与thread）

//  Created by xiaohui on 2018/3/8.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC10.h"
#import "ThreadA.h"

@interface TestVC10 ()

@property (nonatomic, strong) ThreadA *threadA;//强引用

@end

@implementation TestVC10

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //实际上新的线程开启后立马就被销毁了
//    ThreadA *threadA = [[ThreadA alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
//    [threadA start];
    
    
    
    //    _threadA = [[ThreadA alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
    //    [_threadA start];
}

- (void)threadTest {
    NSLog(@"threadTest---%@",[NSThread currentThread]);
    
    //    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSRunLoopCommonModes];
    //    [[NSRunLoop currentRunLoop] run];
    
    //    NSLog(@"111111");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(threadTestContinue) onThread:_threadA withObject:nil waitUntilDone:NO];
}

- (void)threadTestContinue {
    NSLog(@"threadTestContinue---%@",[NSThread currentThread]);
}

@end
