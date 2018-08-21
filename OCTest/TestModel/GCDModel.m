//
//  GCDModel.m
//  OCTest
//
//  Created by xiaohui on 2018/8/21.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "GCDModel.h"

static NSString *_name;
static dispatch_queue_t _concurrentQueue;

@implementation GCDModel

- (instancetype)init {
    if (self = [super init]) {
        _concurrentQueue = dispatch_queue_create("com.xiaohui.111111", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)setName:(NSString *)name {
    dispatch_barrier_async(_concurrentQueue, ^{
        _name = [name copy];
    });
}

- (NSString *)name {
    __block NSString *tempName;
    dispatch_sync(_concurrentQueue, ^{
        tempName = _name;
    });
    return tempName;
}

@end
