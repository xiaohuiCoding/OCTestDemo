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

- (void)addExtensionInset:(UIEdgeInsets)inset{
    objc_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:inset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//重写UIView的内部方法，判断触摸点是否在当前视图内
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    UIEdgeInsets insert = [objc_getAssociatedObject(self, @selector(addExtensionInset:)) UIEdgeInsetsValue];
    CGRect newFrame = CGRectMake(self.bounds.origin.x+insert.left, self.bounds.origin.y+insert.top, self.bounds.size.width-insert.left-insert.right, self.bounds.size.height-insert.top-insert.bottom);
    BOOL b = CGRectContainsPoint(newFrame, point);
    return b;
}

@end
