//
//  NSObject+Runtime.h
//  OCTest
//
//  Created by Apple on 2021/10/27.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)

// 方法交换
- (void)swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
