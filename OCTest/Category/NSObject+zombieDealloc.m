//
//  NSObject+zombieDealloc.m
//  FortunePlat

//  模拟实现僵尸对象

//  Created by sgcy on 2018/7/26.
//  Copyright © 2018年 Tencent. All rights reserved.
//
#import <objc/runtime.h>
#import <Foundation/NSObjCRuntime.h>
#import "NSObject+zombieDealloc.h"

#define ZOMBIE_PREFIX "_NSZombie_"

NS_ROOT_CLASS

@interface _NSZombie_ {
    Class isa;
}

@end

@implementation _NSZombie_

+ (void)initialize {
    
}

@end

@implementation NSObject(zombieDealloc)

// ⚠️Category is implementing a method which will also be implemented by its primary class
// 在分类中重写原类的方法会报警告，加上下面几句宏定义可以忽略～
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (void)dealloc {
    const char *className = object_getClassName(self);
    char *zombieClassName = NULL;
    do {
        if (asprintf(&zombieClassName, "%s%s", ZOMBIE_PREFIX, className) == -1) {
            break;
        }
        
        Class zombieClass = objc_getClass(zombieClassName);
        
        if (zombieClass == Nil) {
            zombieClass = objc_duplicateClass(objc_getClass(ZOMBIE_PREFIX), zombieClassName, 0);
        }
        
        if (zombieClass == Nil) {
            break;
        }
        
        objc_destructInstance(self);
        
        object_setClass(self, zombieClass);
        
    } while (0);
    
    if (zombieClassName != NULL) {
        free(zombieClassName);
    }
}

#pragma clang diagnostic pop

@end
