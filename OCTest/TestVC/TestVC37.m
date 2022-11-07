//
//  TestVC37.m
//  OCTest

//  数据库操作

//  Created by apple on 2022/11/2.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "TestVC37.h"
//#import <FMDB.h> // 采用 pod 集成的方式报错“FMDB.h file not found...”
#import "FMDB.h"

@interface TestVC37 ()

@end

@implementation TestVC37

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *dbPath = @"";
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    NSDate *date1 = [NSDate date];

    // 批量插入数据（事务）
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        for (NSInteger i = 0 ; i < 500; i ++) {
            [self insertItemWithDB:db];
        }
    }];
    
    NSDate *date2 = [NSDate date];
    NSTimeInterval a = [date2 timeIntervalSince1970] - [date1 timeIntervalSince1970];
    NSLog(@"批量插入500条数据的耗时：%.3f秒",a);
}

- (void)insertItemWithDB:(FMDatabase *)db {
    
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
