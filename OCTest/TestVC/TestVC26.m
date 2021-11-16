//
//  TestVC26.m
//  OCTest

//  循环引用 之 NSTimer

//  Created by Apple on 2021/10/25.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC26.h"

/*
 参考：
 https://www.jianshu.com/p/5068b6f02238
 https://zhuanlan.zhihu.com/p/67853194
 */

@interface P2PBomb : NSObject
 
@property (copy, nonatomic) dispatch_block_t block;
@property (strong, nonatomic) NSString *capital;
 
- (void)investment:(NSString *)count year:(NSInteger)year;
 
@end

@implementation P2PBomb

- (void)investment:(NSString *)count year:(NSInteger)year {
    self.capital = count;
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(year * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"本金：%@", strongSelf.capital);
        });
    };
    self.block();
}

@end

@interface TestVC26 ()

@property (strong, nonatomic) P2PBomb *bomb;

@end

@implementation TestVC26

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fireBomb];
}

- (void)fireBomb {
    self.bomb = [[P2PBomb alloc] init];
    [self.bomb investment:@"100W" year:5];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * 2.0)), dispatch_get_main_queue(), ^{
        self.bomb = nil;
    });
}

@end
