//
//  TestVC4.m
//  OCTest

//  __kindof

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC4.h"

@interface TestVC4 ()

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //官方API 1：- (nullable __kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
    //官方API 2：@property(nonatomic,readonly,copy) NSArray<__kindof UIView *> *subviews;
    
    UIButton *button = self.view.subviews.lastObject; //这么写就容易理解了，也不会报警告
    NSLog(@"TestVC3 ---> button.hash = %lu",button.hash);
}

@end
