//
//  TestView.m
//  OCTest
//
//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestView.h"

@implementation TestView

//重写hitTest:withEvent:，以达到让整个目标子视图都能响应事件，即使子视图超出了本视图的范围仍然可以响应事件

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //排除非正常情况
    if (!self.userInteractionEnabled || self.hidden || self.alpha <= 0.01 || self.clipsToBounds) {
        return nil;
    }
    
//    //如果事件发生在本视图内
//    UIView *hitTestView = [super hitTest:point withEvent:event];
//    if (hitTestView) {
//        //如果想让本视图也能响应事件就转移响应者为本视图
//        hitTestView = self.subviews.firstObject;
//        return hitTestView;
//    }

    //下面的代码中如果不注释则是系统默认的实现，注释掉的部分是用来判断点击是否在父View的bounds内，如果不在父view内，就不会去其子View中寻找hitTestView，直接返回了
    
//    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:subPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
//        return self;
//    }
    return nil;
}

@end
