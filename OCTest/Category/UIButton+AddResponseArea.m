//
//  UIButton+AddResponseArea.m
//  OCTest

//  增大响应区域

//  Created by xiaohui on 2018/3/7.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "UIButton+AddResponseArea.h"
#import <objc/runtime.h>

@implementation UIButton (AddResponseArea)

- (void)addInset:(UIEdgeInsets)insets {
    objc_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - rewrite method

//利用runtime
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets insets = [objc_getAssociatedObject(self, @selector(addInset:)) UIEdgeInsetsValue];
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

@end
