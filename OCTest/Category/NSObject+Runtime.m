//
//  NSObject+Runtime.m
//  OCTest
//
//  Created by Apple on 2021/10/27.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

// 方法交换
- (void)swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    // 原方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    // 新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // 如果返回YES，说明原来的方法originalSelector不存在，给类添加一个新方法originalSelector，其实现为swizzledMethod
    BOOL didAddedMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddedMethod) {
        // originalSelector添加后，swizzledSelector的实现用originalMethod取代；
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        // 如果原来的方法originalSelector存在，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
