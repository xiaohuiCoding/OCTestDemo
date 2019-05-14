//
//  UIImage+HookImageName.m
//  OCTest
//
//  Created by xiaohui on 2018/9/6.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "UIImage+HookImageName.h"
#import <objc/runtime.h>

@implementation UIImage (HookImageName)

//+ (void)load {
//    
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        
//        Class selfClass = object_getClass([self class]);
//        
//        SEL oriSEL = @selector(imageNamed:);
//        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
//        
//        SEL cusSEL = @selector(myImageNamed:);
//        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
//        
//        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
//        
//        if (addSucc) {
//            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
//        } else {
//            method_exchangeImplementations(oriMethod, cusMethod);
//        }
//        
//    });
//}

+ (UIImage *)myImageNamed:(NSString *)name {
    
    NSString *newName = [NSString stringWithFormat:@"%@%@", @"new_", name];
    return [self myImageNamed:newName];
}

@end
