//
//  TestVC9.m
//  OCTest

//  RunLoop（runloop 与 performSelector）

//  Created by xiaohui on 2018/3/6.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

/*
 参考：https://www.jianshu.com/p/ac05ac8428ac
      https://segmentfault.com/a/1190000023613543
 */

#import "TestVC9.h"

@interface TestVC9 ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation TestVC9

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //***测试：点击屏幕的空白部分，然后立即连续拖动textView多次，观察图片是否可以在点击屏幕2s后显示出来***//
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 200, 100)];
    [self.view addSubview:_imgView];
    
    
    UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(100, 240, 150, 200)];
    txtView.text = @"连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？连续拖动几下看看图片能否加载出来？";
    [self.view addSubview:txtView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_imgView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"fish"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
    
    //    [_imgView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"fish"] afterDelay:2.0 inModes:@[NSRunLoopCommonModes]];
    
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
}

/*
 一、runloop 的基本概念
 
 1.常说的 runloop 其实就是 CFRunLoopRef，它的内容：一个 runloop 可以包含多个 Mode，一个 Mode 可以包含多个 source timer observer，每次调用 runLoop 的主函数时，只能指定其中一个 Mode，这个Mode被称作 CurrentMode。如果需要切换 Mode，只能退出 Loop，再重新指定一个 Mode 进入。这样做主要是为了分隔开不同组的 Source/Timer/Observer，让其互不影响。
 CFRunLoopModeRef
 CFRunLoopSourceRef
 CFRunLoopTimerRef
 CFRunLoopObserverRef
 
 2.CFRunLoopObserverRef 监听的几种状态
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
 kCFRunLoopEntry = (1UL << 0), //即将进入Runloop
 kCFRunLoopBeforeTimers = (1UL << 1), //即将处理NSTimer
 kCFRunLoopBeforeSources = (1UL << 2), //即将处理Sources
 kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠
 kCFRunLoopAfterWaiting = (1UL << 6), //刚从休眠中唤醒
 kCFRunLoopExit = (1UL << 7), //即将退出runloop
 kCFRunLoopAllActivities = 0x0FFFFFFFU //所有状态改变};
 
 3.几种 Mode 的意义
 kCFRunLoopDefaultMode //App的默认Mode，通常主线程是在这个Mode下运行
 UITrackingRunLoopMode //界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
 UIInitializationRunLoopMode // 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用
 GSEventReceiveRunLoopMode // 接受系统事件的内部 Mode，通常用不到
 kCFRunLoopCommonModes //这是一个占位用的Mode，不是一种真正的Mode
 */

/*
 二、线程与runloop的关系是一一对应的，源码解释如下：
 
 1.全局的字典是 loopsDic，key 是 thread， value 是其对应的 runloop;
 2.访问 loopsDic 时的锁是 static CFSpinLock_t loopsLock;
 3.获取一个 thread 对应的 runLoop;

 // 获取一个线程的 runloop
 CFRunLoopRef _CFRunLoopGet(pthread_t thread) {
     CFRunLoopRefstatic CFMutableDictionaryRef loopsDic; // 声明一个全局的字典，用来存放 thread 和其对应的 loop
     static CFSpinLock_t loopsLock; // 声明一个锁
     OSSpinLockLock(&loopsLock); // 加锁
     if (!loopsDic) {
         loopsDic = CFDictionaryCreateMutable(); // 初始化全局的 loopsDic
         CFRunLoopRef mainLoop = _CFRunLoopCreate(); // 先给主线程创建一个 mainLoop
         CFDictionarySetValue(loopsDic, pthread_main_thread_np(), mainLoop); // 为全局的 loopsDic 添加主线程的 key value
     }
     CFRunLoopRef loop = CFDictionaryGetValue(loopsDic, thread)); // 默认直接从全局的 loopsDic 里获取
     if (!loop) {
         loop = _CFRunLoopCreate(); // 如果取不到就创建一个 runloop
         CFDictionarySetValue(loopsDic, thread, loop); // 为全局的 loopsDic 添加该线程的 key value
         _CFSetTSD(..., thread, loop, __CFFinalizeRunLoop); // 注册一个回调，当线程销毁时，顺便也销毁其对应的 runLoop
     }
     OSSpinLockUnLock(&loopsLock); // 解锁
     return loop;
 }
 
 // 获取主线程的 runloop
 CFRunLoopRef CFRunLoopGetMain() {
     return _CFRunLoopGet(pthread_main_thread_np());
 }
 
 // 获取当前线程的 runloop
 CFRunLoopRef CFRunLoopGetCurrent() {
     return _CFRunLoopGet(pthread_self());
 }
    
 */

@end
