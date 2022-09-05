//
//  NSArray+Description.m
//  OCTest

//  打印对象【如：数组，包含中文，可正常输出】

//  Created by apple on 2022/5/26.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "NSArray+Description.h"
#import <objc/runtime.h>

@implementation NSArray (Description)

+ (void)load {
    // 交换系统类的方法-descriptionWithLocale: 与 自定义的方法-custom_descriptionWithLocale:的指针
    [self exchangeSelector:@selector(descriptionWithLocale:) andNewSelector:@selector(custom_descriptionWithLocale:)];
}

+ (void)exchangeSelector:(SEL)oldSel andNewSelector:(SEL)newSel {
    Method oldMethod =  class_getInstanceMethod([self class], oldSel);
    Method newMethod  = class_getInstanceMethod([self class], newSel);
    // 改变两个方法的具体指针指向
    method_exchangeImplementations(oldMethod, newMethod);
}

- (NSString *)custom_descriptionWithLocale:(id)locale {
    NSString *desc = [self custom_descriptionWithLocale:locale];
    desc = [self replaceUnicode:desc];
    return desc;
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL]; // iOS 8.0已废弃
    NSError *error = nil;
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:&error];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end

/*
要弄清楚selector、IMP、Method三者之间的关系，通俗的方法Method是个结构体。method_exchangeImplementations交换的是这个这个两个方法的IMP。你代码中看到的是[self my_descriptionWithLocale:locale]，实际上执行指向了[self descriptionWithLocale:locale]实现地址的指针，执行的是descriptionWithLocale内部实现。你会问既然交换了，为什么它执行了descriptionWithLocale内部实现，那不是又要取执行my_descriptionWithLocale，这就需要理解selector和IMP关系和作用，因为交换是基于SEL Name 而不是IMP。
 */
