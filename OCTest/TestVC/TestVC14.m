//
//  TestVC14.m
//  OCTest

//  自动释放池的使用

//  Created by xiaohui on 2018/3/21.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC14.h"
#import "PNChart.h"
#import <mach/mach.h>

#define GetScreenWidth      [[UIScreen mainScreen] bounds].size.width

static const int kStep = 100000;
static const int kIterationCount = 10 * kStep;

@interface TestVC14 ()

@property(strong, nonatomic) NSMutableArray *memoryUsageList1;
@property(strong, nonatomic) NSMutableArray *memoryUsageList2;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation TestVC14

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _memoryUsageList1 = [NSMutableArray new];
    _memoryUsageList2 = [NSMutableArray new];
}

- (IBAction)test:(UIButton *)sender {

    sender.enabled = NO;
    [UIView animateWithDuration:0.5f animations:^{
        sender.alpha = 0.1;
    }];
    
    //创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("com.xiaohui.TestVC14.autoreleasepool", DISPATCH_QUEUE_SERIAL);
    
    //使用自动释放池
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < kIterationCount; i++) {
            @autoreleasepool {
                NSNumber *num = [NSNumber numberWithInt:i];
                NSString *str = [NSString stringWithFormat:@"%d ", i];
                [NSString stringWithFormat:@"%@%@", num, str];
                if (i % kStep == 0) {
                    NSLog(@"整除1");
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
            [NSString stringWithFormat:@"%@%@", num, str];
            if (i % kStep == 0) {
                NSLog(@"整除2");
                [_memoryUsageList2 addObject:@(getMemoryUsage())];
            }
        }
    });
    
    //测试完成
    dispatch_sync(serialQueue, ^{
        NSLog(@"done");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showResult];
            _infoLabel.text = @"测试完成";
        });
    });
}

- (void)showResult {
    PNLineChart *chartView = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 320)];
    chartView.showCoordinateAxis = YES;
    chartView.yFixedValueMax = 150;
    chartView.yFixedValueMin = 0;
    chartView.yUnit = @"MB";
    chartView.legendStyle = PNLegendItemStyleStacked;
    chartView.legendFontSize = 12.0f;
    
    PNLineChartData *lineData1 = [PNLineChartData new];
    lineData1.dataTitle = @"With @autoreleasepool";
    lineData1.color = PNFreshGreen;
    lineData1.alpha = 0.8;
    lineData1.itemCount = _memoryUsageList1.count;
    lineData1.inflexionPointStyle = PNLineChartPointStyleTriangle;
    lineData1.getData = ^(NSUInteger index) {
        NSLog(@"getData111");
        return [PNLineChartDataItem dataItemWithY:[((NSNumber *)_memoryUsageList1[index]) floatValue]];
    };
    
    PNLineChartData *lineData2 = [PNLineChartData new];
    lineData2.dataTitle = @"Without @autoreleasepool";
    lineData2.color = PNWeiboColor;
    lineData2.alpha = 0.8;
    lineData2.itemCount = _memoryUsageList2.count;
    lineData2.inflexionPointStyle = PNLineChartPointStyleCircle;
    lineData2.getData = ^(NSUInteger index) {
        NSLog(@"getData222");
        return [PNLineChartDataItem dataItemWithY:[((NSNumber *)_memoryUsageList2[index]) floatValue]];
    };
    
    chartView.chartData = @[lineData1, lineData2];
    [chartView strokeChart];//内部需要用到chartData，进而会再次使用getData回调，所以会打印两遍getDataxxx。
    [self.view addSubview:chartView];
    
    UIView *legend = [chartView getLegendWithMaxWidth:SCREEN_WIDTH];
    [legend setFrame:CGRectMake(10, 400, legend.frame.size.width, legend.frame.size.height)];
    [self.view addSubview:legend];
}

//获取内存
double getMemoryUsage(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    double memoryUsageInMB = kerr == KERN_SUCCESS ? (info.resident_size / 1024.0 / 1024.0) : 0.0;
    return memoryUsageInMB;
}

@end
