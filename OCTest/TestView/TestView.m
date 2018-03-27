//
//  TestView.m
//  OCTest
//
//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestView.h"

@implementation TestView

//重写hitTest方法，让子视图超出父视图的部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.userInteractionEnabled || self.hidden || (self.alpha < 0.01) || self.clipsToBounds) {
        return nil;
    }
    //如果事件发生在父视图里就返回
    UIView *result = [super hitTest:point withEvent:event];
    if (result) {
        return result;
    }
    //如果不在父视图里就遍历子视图
    for (UIView *subview in self.subviews) {
        //把这个坐标从父视图的坐标系转为子视图的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        UIView *result = [subview hitTest:subPoint withEvent:event];
        //如果事件发生在子视图里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

@end
