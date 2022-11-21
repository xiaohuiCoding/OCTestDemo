//
//  UIControl+ClickInterval.m
//  OCTest

//  阻止频繁的点击事件

//  Created by apple on 2022/10/26.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "UIControl+ClickInterval.h"
#import <objc/runtime.h>

static double kDefaultInterval = 2.0;

@interface UIControl ()

// 是否可以点击
@property (nonatomic, assign) BOOL isIgnoreClick;

// 上次按钮响应的方法名
@property (nonatomic, strong) NSString *oldSELName;

@end

@implementation UIControl (ClickInterval)

+ (void)kk_exchangeClickMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 获得方法选择器
        SEL originalSel = @selector(sendAction:to:forEvent:);
        SEL newSel = @selector(kk_sendClickIntervalAction:to:forEvent:);
        // 获得方法
        Method originalMethod = class_getInstanceMethod(self , originalSel);
        Method newMethod = class_getInstanceMethod(self , newSel);

        // 这里做判断是为了避免原方法的实现不存在的情况。如果返回YES就是添加成功了，说明原方法的实现不存在(就先添加被替换方法的实现，然后替换)，否则就返回NO；
        BOOL isAddNewMethod = class_addMethod(self, originalSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (isAddNewMethod) {
            // 替换方法的实现
            class_replaceMethod(self, newSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            // 交换方法的实现
            method_exchangeImplementations(originalMethod, newMethod);
        }
    });
}

- (void)kk_sendClickIntervalAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([self isKindOfClass:[UIButton class]] && !self.ignoreClickInterval) {
        if (self.clickInterval <= 0) {
            self.clickInterval = kDefaultInterval;
        };

        NSString *currentSELName = NSStringFromSelector(action);
        if (self.isIgnoreClick && [self.oldSELName isEqualToString:currentSELName]) {
            return;
        }

        if (self.clickInterval > 0) {
            self.isIgnoreClick = YES;
            self.oldSELName = currentSELName;
            [self performSelector:@selector(kk_ignoreClickState:)
                       withObject:@(NO)
                       afterDelay:self.clickInterval];
        }
    }
    [self kk_sendClickIntervalAction:action to:target forEvent:event];
}

- (void)kk_ignoreClickState:(NSNumber *)ignoreClickState {
    self.isIgnoreClick = ignoreClickState.boolValue;
    self.oldSELName = @"";
}

- (NSTimeInterval)clickInterval {

    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setClickInterval:(NSTimeInterval)clickInterval {
    objc_setAssociatedObject(self, @selector(clickInterval), @(clickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreClick {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnoreClick:(BOOL)isIgnoreClick {
    objc_setAssociatedObject(self, @selector(isIgnoreClick), @(isIgnoreClick), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ignoreClickInterval {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIgnoreClickInterval:(BOOL)ignoreClickInterval {
    objc_setAssociatedObject(self, @selector(ignoreClickInterval), @(ignoreClickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)oldSELName {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOldSELName:(NSString *)oldSELName {
    objc_setAssociatedObject(self, @selector(oldSELName), oldSELName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
