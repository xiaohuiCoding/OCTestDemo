//
//  UIControl+ClickInterval.h
//  OCTest

//  阻止频繁的点击事件

//  Created by apple on 2022/10/26.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 使用方法：在全局 或 在UIControl对象所在的类中加入此句代码：[UIControl kk_exchangeClickMethod];
 */

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (ClickInterval)

// 点击事件响应的时间间隔，不设置或者大于 0 时为默认时间间隔
@property (nonatomic, assign) NSTimeInterval clickInterval;

// 是否忽略响应的时间间隔
@property (nonatomic, assign) BOOL ignoreClickInterval;

+ (void)kk_exchangeClickMethod;

@end

NS_ASSUME_NONNULL_END
