//
//  KVOModel.m
//  OCTest
//
//  Created by xiaohui on 2019/6/2.
//  Copyright © 2019 XIAOHUI. All rights reserved.
//

#import "KVOModel.h"

@implementation KVOModel

#pragma mark - KVO method

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"array"]) {
//        NSLog(@"%@",change);
//        for (NSString *str in self.array) {
//            NSLog(@"%@",str);
//        }
//    }
//}

//会发现打印的change中，indexes描述了变化的index，kind = 2是表示NSKeyValueChangeInsertion，是NSKeyValueChange的枚举值中的一种，即：数组新插入了一个数据，new就是一个增加的数据数组。
//NSKeyValueChange共有四种枚举值：NSKeyValueChangeSetting，NSKeyValueChangeInsertion，NSKeyValueChangeRemoval和NSKeyValueChangeReplacement，分别表示：创建，增加，删除，替换。

@end
