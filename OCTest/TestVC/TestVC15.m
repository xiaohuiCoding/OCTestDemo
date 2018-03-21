//
//  TestVC15.m
//  OCTest

//  GCD的使用

//  Created by xiaohui on 2018/3/21.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC15.h"

@interface TestVC15 ()

@end

@implementation TestVC15

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        for (NSInteger i = 0; i < 1000000; i++) {
    //            @autoreleasepool {
    //                NSNumber *num = [NSNumber numberWithInteger:i];
    //                NSString *str = [NSString stringWithFormat:@"%ld", i];
    //                [NSString stringWithFormat:@"%@%@", num, str];
    //            }
    //        }
    //    });
    
    //    dispatch_queue_t newQueue = dispatch_queue_create("NewQueue", DISPATCH_QUEUE_SERIAL);
    //
    //    dispatch_async(newQueue, ^{
    //        for (NSInteger i = 0; i < 1000000; i++) {
    //            @autoreleasepool {
    //                NSNumber *num = [NSNumber numberWithInteger:i];
    //                NSString *str = [NSString stringWithFormat:@"%ld", i];
    //                [NSString stringWithFormat:@"%@%@", num, str];
    //            }
    //        }
    //    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
