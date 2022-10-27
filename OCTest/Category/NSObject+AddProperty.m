//
//  NSObject+AddProperty.m
//  OCTest

//  给分类添加属性

//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "NSObject+AddProperty.h"
#import <objc/runtime.h>

/*
 参考：https://blog.csdn.net/u014600626/article/details/51435943
 */

@implementation NSObject (AddProperty)

- (void)setSmallName:(NSString *)smallName {
    objc_setAssociatedObject(self, @"smallName", smallName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)smallName {
    return objc_getAssociatedObject(self, @"smallName");
}

@end
