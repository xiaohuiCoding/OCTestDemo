//
//  TestVC36.m
//  OCTest

//  组件化

//  Created by apple on 2022/9/17.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "TestVC36.h"
#import <XHBaseModule/XHBaseModule.h>

@interface TestVC36 ()

@end

@implementation TestVC36

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XHBaseModel *m = [[XHBaseModel alloc] init];
    m.name = @"基础组件名";
    self.navigationItem.title = m.name;
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
