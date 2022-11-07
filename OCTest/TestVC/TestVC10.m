//
//  TestVC10.m
//  OCTest

//  RunLoop（runloop 与 thread）线程常驻的应用

//  Created by xiaohui on 2018/3/8.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC10.h"
#import "ThreadA.h"

/*
 参考：https://www.jianshu.com/p/d260d18dd551
 */

@interface TestVC10 ()

@property (nonatomic, strong) ThreadA *threadA;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TestVC10

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeTimer];
}

- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 方式一：第一次任务执行后，后续事件不会响应！这样开启新线程，实际上在开启后该线程立即就被系统销毁了，查看其是否调用了-dealloc方法便知
//    ThreadA *threadA = [[ThreadA alloc] initWithTarget:self selector:@selector(currentThreadTest) object:nil];
//    [threadA start];
    
    
    // 方式一：第一次任务执行后，后续事件会持续响应！为了不让线程在开启后被销毁，可以采用强引用的方式保留！！！
    _threadA = [[ThreadA alloc] initWithTarget:self selector:@selector(currentThreadTest) object:nil];
//    _threadA = [[ThreadA alloc] initWithBlock:^{
//        [self currentThreadTest];
//    }];//iOS 10 新增的API
    [_threadA start];
}

// 测试点击屏幕的事件
- (void)currentThreadTest {
    NSLog(@"currentThread---%@",[NSThread currentThread]);

    // 新建的子线程默认是没有添加Runloop的，因此给这个线程添加了一个runloop，并且加了一个NSMachPort，来防止这个新建的线程由于没有活动直接退出。
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}

// 测试定时器的事件
//- (void)currentThreadTest {
//    NSLog(@"currentThread---%@",[NSThread currentThread]);
//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(touchScreenEvent) onThread:_threadA withObject:nil waitUntilDone:NO];
}

- (void)touchScreenEvent {
    NSLog(@"111---currentThread---%@",[NSThread currentThread]);
}

- (void)timerEvent {
    NSLog(@"222---currentThread---%@",[NSThread currentThread]);
}

@end
