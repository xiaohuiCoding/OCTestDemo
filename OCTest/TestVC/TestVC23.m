//
//  TestVC23.m
//  OCTest
//
//  Created by xiaohui on 2019/6/2.
//  Copyright © 2019 XIAOHUI. All rights reserved.
//

#import "TestVC23.h"
#import "KVOModel.h"

@interface TestVC23 ()

@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (nonatomic, strong) KVOModel *model;

@end

@implementation TestVC23

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.model = [[KVOModel alloc] init];
//    self.model.array = [NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];//可变数组的初始化是必须的，否则增加监听后再操作数组程序会crash。
    
    
    //1.别人观察model的属性
    
    [self.model addObserver:self forKeyPath:@"array" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    //2.model观察本身的属性，-observeValueForKeyPath 方法需要写在本身的.m文件里
    
//    [self.model addObserver:self.model forKeyPath:@"array" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

//数组初始化
- (IBAction)button0Clicked:(id)sender {
    self.model.array = [NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];
}

//增加一个元素
- (IBAction)button1Clicked:(id)sender {
    //当我们要获取这个KVOModel的array时，不能简单用model.array，而必须调用-mutableArrayValueForKey，只有这样，得到的数组发生变化了才会收到通知。
    [[self.model mutableArrayValueForKey:@"array"] addObject:@"3"];
}

//删除某个元素
- (IBAction)button2Clicked:(id)sender {
    [[self.model mutableArrayValueForKey:@"array"] removeObject:@"0"];
}

//替换某个元素
- (IBAction)button3Clicked:(id)sender {
    [[self.model mutableArrayValueForKey:@"array"] replaceObjectAtIndex:0 withObject:@"4"];
}

#pragma mark - KVO method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"array"]) {
        NSLog(@"%@",change);
        for (NSString *str in self.model.array) {
            NSLog(@"%@",str);
        }
    }
}

@end
