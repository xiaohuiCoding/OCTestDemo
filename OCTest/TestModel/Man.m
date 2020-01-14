//
//  Man.m
//  OCTest
//
//  Created by fengxiaohui on 2020/1/8.
//  Copyright © 2020 XIAOHUI. All rights reserved.
//

#import "Man.h"

@implementation Man

+ (void)load {
    NSLog(@"%s",__func__);
}

+ (void)initialize {
//    [super initialize];
    NSLog(@"%s %@",__func__,[self class]);
}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%s",__func__);
    }
    return self;
}

@end
