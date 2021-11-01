//
//  NSMutableArray+Safe.m
//  OCTest
//
//  Created by Apple on 2021/10/27.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Runtime.h"

@implementation NSMutableArray (Safe)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSMutableArray *obj = [[NSMutableArray alloc] init];
//        [obj swizzleMethodWithOriginalSelector:@selector(addObject:) swizzledSelector:@selector(hookAddObject:)];
//    });
//}

- (void)hookAddObject:(id)object {
    // 添加的对象为nil时直接过滤
    if (object == nil) {
        return;
    }
    [self hookAddObject:object];
}

@end
