//
//  Boy.h
//  OCTest
//
//  Created by xiaohui on 2018/6/6.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Girl.h"

//外部可用的常量
extern NSString * const kString;

@interface Boy : NSObject

@property (nonatomic, strong) Girl *girl;

- (void)test;

@end
