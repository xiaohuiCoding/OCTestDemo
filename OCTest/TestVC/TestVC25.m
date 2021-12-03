//
//  TestVC25.m
//  OCTest

//  InterView

//  Created by Apple on 2021/10/18.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC25.h"

/*
 参考：
 精华篇：https://www.jianshu.com/p/0930e13c9898
 精华篇：https://zhuanlan.zhihu.com/p/186875101
 面试题大全：https://github.com/xiaohuiCoding/GoldHouse-for-iOS
 面试题大全：https://www.jianshu.com/p/69d719568ae2
 */

@interface Father : NSObject

@end

@implementation Father

@end

@interface Son : Father

@property (nonatomic, copy) NSString *name;

@end

@implementation Son

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}

@end

@interface TestVC25 ()

@end

@implementation TestVC25

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Son *s = [[Son alloc] init];
    s.name = @"儿子";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
