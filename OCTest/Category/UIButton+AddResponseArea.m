//
//  UIButton+AddResponseArea.m
//  OCTest

//  扩大响应区域

//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "UIButton+AddResponseArea.h"
#import <objc/runtime.h>

@implementation UIButton (AddResponseArea)

//重写hitTest:withEvent: 或 pointInside:withEvent:，旨在扩大自身区域，让点落在区域内以达到可以响应事件的目的

#pragma mark - common method

- (void)addInsets:(UIEdgeInsets)insets {
    objc_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*** 第一种方法 ***/

#pragma mark - rewrite method

//利用runtime
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets insets = [objc_getAssociatedObject(self, @selector(addInsets:)) UIEdgeInsetsValue];
    CGRect newbounds = CGRectMake(self.bounds.origin.x+insets.left, self.bounds.origin.y+insets.top, self.bounds.size.width-insets.left-insets.right, self.bounds.size.height-insets.top-insets.bottom);
    return CGRectContainsPoint(newbounds, point);
}

////不利用runtime
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    UIEdgeInsets insets = self.contentEdgeInsets;
//    CGRect newbounds = CGRectMake(self.bounds.origin.x+insets.left, self.bounds.origin.y+insets.top, self.bounds.size.width-insets.left-insets.right, self.bounds.size.height-insets.top-insets.bottom);
////    CGRect newbounds = CGRectInset(self.bounds, -10, -10);//有局限性，只能写死，无法兼顾上下左右的值
//    return CGRectContainsPoint(newbounds, point);
//}

/*** 第二种方法 ***/

#pragma mark - rewrite method

////利用runtime
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (!self.userInteractionEnabled || self.hidden || self.alpha <= 0.01 || self.clipsToBounds) {
//        return nil;
//    }
//    UIEdgeInsets insets = [objc_getAssociatedObject(self, @selector(addInset:)) UIEdgeInsetsValue];
//    CGRect newbounds = CGRectMake(self.bounds.origin.x+insets.left, self.bounds.origin.y+insets.top, self.bounds.size.width-insets.left-insets.right, self.bounds.size.height-insets.top-insets.bottom);
//    if (CGRectContainsPoint(newbounds, point)) {
//        for (UIView *subView in [self.subviews reverseObjectEnumerator]) {
//            CGPoint convertedPoint = [subView convertPoint:point fromView:self];
//            UIView *hitTestView = [subView hitTest:convertedPoint withEvent:event];
//            if (hitTestView) {
//                return hitTestView;
//            }
//        }
//        return self;
//    }
//    return nil;
//}

////不利用runtime
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (!self.userInteractionEnabled || self.hidden || self.alpha <= 0.01 || self.clipsToBounds) {
//        return nil;
//    }
//    UIEdgeInsets insets = self.contentEdgeInsets;
//    CGRect newbounds = CGRectMake(self.bounds.origin.x+insets.left, self.bounds.origin.y+insets.top, self.bounds.size.width-insets.left-insets.right, self.bounds.size.height-insets.top-insets.bottom);
//    if (CGRectContainsPoint(newbounds, point)) {
//        for (UIView *subView in [self.subviews reverseObjectEnumerator]) {
//            CGPoint convertedPoint = [subView convertPoint:point fromView:self];
//            UIView *hitTestView = [subView hitTest:convertedPoint withEvent:event];
//            if (hitTestView) {
//                return hitTestView;
//            }
//        }
//        return self;
//    }
//    return nil;
//}

@end
