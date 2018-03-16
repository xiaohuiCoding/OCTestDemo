//
//  ModelA.m
//  OCTest
//
//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "ModelA.h"

@implementation ModelA

//+ (NSDictionary *)generateDictionaryWithModel {
//    return @{@"listB":@"ModelB"};
//}

+ (NSDictionary *)generateDictionaryWithModel {
    return @{@"listB":@"ModelB", @"listC":@"ModelC"};
}

- (void)test {
    NSLog(@"model A method execute");
}

@end
