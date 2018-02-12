//
//  Test_Nullability.m
//  OCTest

//  为空性

//  Created by xiaohui on 2018/2/5.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "Test_Nullability.h"

@implementation Test_Nullability

- (instancetype)init1WithCompletionBlock:(TestBlock)block {
    return nil;
}

- (instancetype)init2WithCompletionBlock:(void (^)(BOOL))block {
    return nil;
}

- (instancetype)init3WithCompletionBlock:(void (^)(NSString * _Nullable))block {
    return nil;
}

- (instancetype)init4WithCompletionBlock:(id  _Nullable (^)(NSString * _Nullable))block {
    return nil;
}

- (void)test1WithCompletionBlock:(void (^)(BOOL))block {
    
}

- (void)test2WithCompletionBlock:(void (^)(NSString * _Nullable))block {
    
}

@end

@implementation Member

@end

@implementation Team

- (instancetype)initWithMember:(Member *)member {
    return nil;
}

- (void)updateTeamData:(void (^)(NSError * _Nullable))block {
    
}

@end
