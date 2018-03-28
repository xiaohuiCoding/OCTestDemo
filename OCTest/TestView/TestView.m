//
//  TestView.m
//  OCTest
//
//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/**
 
 *  第一响应者（First responder）指的是当前接受触摸的响应者对象（通常是一个 UIView 对象），即表示当前该对象正在与用户交互，它是响应者链的开端。响应者链和事件分发的使命都是找出第一响应者。
 
 *  iOS 系统检测到手指触摸 (Touch) 操作时会将其打包成一个 UIEvent 对象，并放入当前活动 Application 的事件队列，单例的 UIApplication 会从事件队列中取出触摸事件并传递给单例的 UIWindow 来处理，UIWindow 对象首先会使用 hitTest:withEvent:方法寻找此次 Touch 操作初始点所在的视图(View)，即需要将触摸事件传递给其处理的视图，这个过程称之为 hit-test view。
 
 *  hitTest:withEvent:方法的处理流程如下:
    首先调用当前视图的 pointInside:withEvent: 方法判断触摸点是否在当前视图内；
    若返回 NO, 则 hitTest:withEvent: 返回 nil，若返回 YES, 则向当前视图的所有子视图 (subviews) 发送 hitTest:withEvent: 消息，所有子视图的遍历顺序是从最顶层视图一直到到最底层视图，即从 subviews 数组的末尾向前遍历，直到有子视图返回非空对象或者全部子视图遍历完毕；
    若第一次有子视图返回非空对象，则 hitTest:withEvent: 方法返回此对象，处理结束；
    如果所有子视图都返回空，则 hitTest:withEvent: 方法返回自身 (self)。
 
 */

//下面是模拟系统的内部实现：
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *touchView = self;
//    if ([self pointInside:point withEvent:event] && !self.hidden && self.userInteractionEnabled && self.alpha >= 0.01) {
//        for (UIView *subview in self.subviews) {
//            CGPoint subpoint = [subview convertPoint:point fromView:self];
//            UIView *subTouchView = [subview hitTest:subpoint withEvent:event];
//            if (subTouchView) {
//                touchView = subTouchView;
//                break;
//            }
//        }
//    } else {
//        touchView = nil;
//    }
//    return touchView;
//}



/**
 
 *  下面的代码和上面的代码的差别就是取消了pointInside:withEvent函数的检测，这样就可以捕获到当前frame范围以外的子view的触摸事件。
 
 */

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *touchView = self;
    if (!self.hidden && self.userInteractionEnabled && self.alpha >= 0.01) {
        for (UIView *subview in self.subviews) {
            CGPoint subpoint = [subview convertPoint:point fromView:self];
            UIView *subTouchView = [subview hitTest:subpoint withEvent:event];
            if (subTouchView) {
                touchView = subTouchView;
                break;
            }
        }
    } else {
        touchView = nil;
    }
    return touchView;
}

@end
