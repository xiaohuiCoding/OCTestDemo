//
//  NSObject+AddProperty.m
//  OCTest
//
//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "NSObject+AddProperty.h"
#import <objc/runtime.h>

@implementation NSObject (AddProperty)

- (void)setSmallName:(NSString *)smallName {
    objc_setAssociatedObject(self, @"smallName", smallName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)smallName {
    return objc_getAssociatedObject(self, @"smallName");
}

@end
