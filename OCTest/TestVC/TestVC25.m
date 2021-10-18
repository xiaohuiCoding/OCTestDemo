//
//  TestVC25.m
//  OCTest
//
//  Created by Apple on 2021/10/18.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC25.h"

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
