//
//  TestVC10.m
//  OCTest

//  RunLoop（runloop 与 thread）

//  Created by xiaohui on 2018/3/8.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC10.h"
#import "ThreadA.h"

@interface TestVC10 ()

@property (nonatomic, strong) ThreadA *threadA;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TestVC10

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //像这样开启新线程，实际上在开启后该线程立即就被系统销毁了，查看其是否调用了-dealloc方法便知
//    ThreadA *threadA = [[ThreadA alloc] initWithTarget:self selector:@selector(currentThreadTest) object:nil];
//    [threadA start];
    
    
    //为了不让线程在开启后被销毁，可以采用强引用的方式保留
    _threadA = [[ThreadA alloc] initWithTarget:self selector:@selector(currentThreadTest) object:nil];
//    _threadA = [[ThreadA alloc] initWithBlock:^{
//        [self currentThreadTest];
//    }];//iOS 10 新增的API
    [_threadA start];
}

- (void)currentThreadTest {
    NSLog(@"currentThread---%@",[NSThread currentThread]);

    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];

    NSLog(@"111111");
    
    
    
    //在子线程中执行定时器事件，需要将定时器加到当前子线程中
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
//
//    NSLog(@"222222");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(currentThreadTestAgain) onThread:_threadA withObject:nil waitUntilDone:NO];
}

- (void)currentThreadTestAgain {
    NSLog(@"currentThreadAgain---%@",[NSThread currentThread]);
}

- (void)timerTest {
    NSLog(@"currentThread---%@",[NSThread currentThread]);
}

- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
