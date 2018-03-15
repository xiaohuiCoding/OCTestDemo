//
//  RuntimeTestModel.m
//  OCTest

//  利用 runtime 实现本类中的方法交换 和 不同类中的方法交换

//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "RuntimeTestModel.h"
#import <objc/runtime.h>
#import "ModelA.h"
#import "ModelB.h"

@implementation RuntimeTestModel

//+ (void)load {
//    Method method1 = class_getInstanceMethod(self, @selector(test1));
//    Method method2 = class_getInstanceMethod(self, @selector(test2));
//    method_exchangeImplementations(method1, method2);
//
//    Method method3 = class_getInstanceMethod([ModelA class], @selector(test));
//    Method method4 = class_getInstanceMethod([ModelB class], @selector(test));
//    method_exchangeImplementations(method3, method4);
//}

+ (void)initialize {
    Method method1 = class_getInstanceMethod(self, @selector(test1));
    Method method2 = class_getInstanceMethod(self, @selector(test2));
    method_exchangeImplementations(method1, method2);
    
    Method method3 = class_getInstanceMethod([ModelA class], @selector(test));
    Method method4 = class_getInstanceMethod([ModelB class], @selector(test));
    method_exchangeImplementations(method3, method4);
}

- (void)test1 {
    NSLog(@"test1 execute");
}

- (void)test2 {
    NSLog(@"test2 execute");
}

@end
