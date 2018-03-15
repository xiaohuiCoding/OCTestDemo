//
//  TestVC5.m
//  OCTest

//  hash 与 equal

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC5.h"
#import "Person.h"

@interface TestVC5 ()

@end

@implementation TestVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    Person *p = [[Person alloc] init];
    NSLog(@"p的hash值=%lu",p.hash);
    [p copy];
    
    
    
    Person *p1 = [[Person alloc] init];
    p1.name = @"xiaoming";
    p1.gender = @"male";
    
    Person *p2 = [[Person alloc] init];
    p2.name = @"xiaoming";
    p2.gender = @"male";
    
    NSLog(@"p1 == p2 = %@", p1 == p2 ? @"YES" : @"NO");
    NSLog(@"[p1 isEqual:p2] = %@", [p1 isEqual:p2] ? @"YES" : @"NO");
    
    UIColor *color1 = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    
    NSLog(@"color1 == color2 = %@", color1 == color2 ? @"YES" : @"NO");
    NSLog(@"[color1 isEqual:color2] = %@", [color1 isEqual:color2] ? @"YES" : @"NO");
}

@end
