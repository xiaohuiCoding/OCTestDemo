//
//  TestVC14.m
//  OCTest

//  自动释放池的使用

//  Created by xiaohui on 2018/3/21.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC14.h"
#import <mach/mach.h>

#define DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), (mainQueueBlock));

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

static const int kStep = 100000;
static const int kIterationCount = 10 * kStep;

@interface TestVC14 ()

@property(strong, nonatomic) NSMutableArray *memoryUsageList1;
@property(strong, nonatomic) NSMutableArray *memoryUsageList2;

@end

@implementation TestVC14

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Init
    _memoryUsageList1 = [NSMutableArray new];
    _memoryUsageList2 = [NSMutableArray new];
}

- (IBAction)test:(UIButton *)sender {

    sender.enabled = NO;
    [UIView animateWithDuration:0.5f animations:^{
        sender.alpha = 0.1;
    }];
    
    
    //创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("me.tutuge.test.autoreleasepool", DISPATCH_QUEUE_SERIAL);
    
    
    //使用自动释放池
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < kIterationCount; i++) {
            @autoreleasepool {
                NSNumber *num = [NSNumber numberWithInt:i];
                NSString *str = [NSString stringWithFormat:@"%d ", i];
                
                //Use num and str...whatever...
                [NSString stringWithFormat:@"%@%@", num, str];
                
                if (i % kStep == 0) {
                    [_memoryUsageList1 addObject:@(getMemoryUsage())];
                }
            }
        }
    });
    
    //不使用自动释放池
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < kIterationCount; i++) {
            NSNumber *num = [NSNumber numberWithInt:i];
            NSString *str = [NSString stringWithFormat:@"%d ", i];
            
            //Use num and str...whatever...
            [NSString stringWithFormat:@"%@%@", num, str];
            
            if (i % kStep == 0) {
                [_memoryUsageList2 addObject:@(getMemoryUsage())];
            }
        }
    });
    
    //测试完成
    dispatch_sync(serialQueue, ^{
        DISPATCH_ON_MAIN_THREAD(^{
            for (NSInteger i = 0; i < _memoryUsageList1.count; i++) {
                NSLog(@"使用自动释放池：%@",_memoryUsageList1[i]);
            }
            for (NSInteger i = 0; i < _memoryUsageList2.count; i++) {
                NSLog(@"不使用自动释放池：%@",_memoryUsageList2[i]);
            }
        })
    });
}

#pragma mark - Memory methods

double getMemoryUsage(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    double memoryUsageInMB = kerr == KERN_SUCCESS ? (info.resident_size / 1024.0 / 1024.0) : 0.0;
    return memoryUsageInMB;
}

@end
