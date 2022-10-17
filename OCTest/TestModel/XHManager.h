//
//  XHManager.h
//  OCTest

//  写一个靠谱的单例

//  Created by apple on 2022/9/21.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHManager : NSObject

+ (instancetype)sharedInstance;

// 可以直接禁止掉下面的初始化方式，必须使用标准化的初始化方式，避免多人合作时初始化的方式不统一！
//+ (instancetype)alloc __attribute__((unavailable("replace with 'sharedInstance'")));
//
//+ (instancetype)new __attribute__((unavailable("replace with 'sharedInstance'")));
//
//- (instancetype)copy __attribute__((unavailable("replace with 'sharedInstance'")));
//
//- (instancetype)mutableCopy __attribute__((unavailable("replace with 'sharedInstance'")));

@end

NS_ASSUME_NONNULL_END
