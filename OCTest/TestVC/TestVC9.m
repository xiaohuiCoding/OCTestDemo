//
//  TestVC9.m
//  OCTest

//  RunLoop（runloop 与 performSelector）

//  Created by xiaohui on 2018/3/6.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

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
    
    /*
     1.CFRunLoopRef就是RunLoop，而SourceRef、TimerRef、ObserverRef是CFRunLoopRef的内容，而ModeRef指的是mode的属性。
     
     CFRunLoopRef
     CFRunLoopModeRef
     CFRunLoopSourceRef
     CFRunLoopTimerRef
     CFRunLoopObserverRef
     
     
     2.CFRunLoopObserverRef，是RunLoop的监听者，监听的状态如下：

     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0), //即将进入Runloop
     kCFRunLoopBeforeTimers = (1UL << 1), //即将处理NSTimer
     kCFRunLoopBeforeSources = (1UL << 2), //即将处理Sources
     kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠
     kCFRunLoopAfterWaiting = (1UL << 6), //刚从休眠中唤醒
     kCFRunLoopExit = (1UL << 7), //即将退出runloop
     kCFRunLoopAllActivities = 0x0FFFFFFFU //所有状态改变};
     
     3.
     kCFRunLoopDefaultMode //App的默认Mode，通常主线程是在这个Mode下运行
     UITrackingRunLoopMode //界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
     UIInitializationRunLoopMode // 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用
     GSEventReceiveRunLoopMode // 接受系统事件的内部 Mode，通常用不到
     kCFRunLoopCommonModes //这是一个占位用的Mode，不是一种真正的Mode

     */
}

@end
