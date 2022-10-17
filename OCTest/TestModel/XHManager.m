//
//  XHManager.m
//  OCTest

//  写一个靠谱的单例

//  Created by apple on 2022/9/21.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "XHManager.h"

static XHManager *instance = nil;

@implementation XHManager

// 方式一：常规写法，默认使用这种初始化方式创建单例对象！

//+ (instancetype)sharedInstance {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        @synchronized (self) {
//            if (instance == nil) {
//                instance = [[XHManager alloc] init];
//            }
//        }
//    });
//    return instance;
//}


// 方式二：不论使用什么初始化方式创建单例对象(比如：sharedInstance, [alloc init], new, copy, mutableCopy)，可以确保都是同一个！

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [[self class] sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone {
    return [[self class] sharedInstance];
}

@end
