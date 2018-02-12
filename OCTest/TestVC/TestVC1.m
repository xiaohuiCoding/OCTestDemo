//
//  TestVC1.m
//  OCTest

//  属性声明时的关键字

//  Created by xiaohui on 2018/2/10.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "TestVC1.h"
#import "Test_Nullability.h"

/**
 
 1.当修饰可变类型的属性时，如NSMutableArray、NSMutableDictionary、NSMutableString，用strong；
 
 2.当修饰不可变类型的属性时，如NSArray、NSDictionary、NSString，用copy；
 
 3.容器类大多都遵循NSCopy协议。对于copy修饰的可变容器，self.container = [NSMutableContainer new];得到的是不可变容器。具体原因查阅setter方法的内部实现。同理_container = xxx还是可变容器。getter没有在内部实现[_container copy]这个动作；
 
 4.在纯手码实现界面布局时，如果通过懒加载构建界面控件，需要使用strong强指针；（视图属性用weak还是strong应视情况而定！）
 
 **/

@interface TestVC1 ()

@property (nonatomic, strong) NSMutableArray *stMuArray;//建议这么声明（√）
@property (nonatomic, copy) NSMutableArray *cpMuArray;//不建议这么声明（X）

@property (nonatomic, strong) NSArray *stArray;//不建议这么声明（X）
@property (nonatomic, copy) NSArray *cpArray;//建议这么声明（√）

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.stMuArray = [NSMutableArray array];
    [self.stMuArray addObject:@"1"];
    
    
    
//    self.cpMuArray = [NSMutableArray array];//类型变了，得到的是不可变数组，可能会出bug或crash（原因是setter会在内部进行copy操作）
    _cpMuArray = [NSMutableArray array];//类型不变（getter不会在内部进行copy操作，如果用copy声明了，可以用懒加载来规避这个问题）
    [self.cpMuArray addObject:@"1"];
    
    
    
    self.stArray = [NSArray array];
    NSMutableArray *tempArray1 = [NSMutableArray array];
    [tempArray1 addObject:@"1"];
    self.stArray = tempArray1;
    [tempArray1 addObject:@"2"]; //stArray会随着array的变化而变化
    
    
    
    self.cpArray = [NSArray array];
    NSMutableArray *tempArray2 = [NSMutableArray array];
    [tempArray2 addObject:@"1"];
    self.cpArray = tempArray2;
    [tempArray2 addObject:@"2"]; //stArray不会随着array的变化而变化
}

- (NSMutableArray *)stMuArray {
    if (!_stMuArray) {
        _stMuArray = [NSMutableArray array];
    }
    return _stMuArray;
}

- (NSMutableArray *)cpMuArray {
    if (!_cpMuArray) {
        _cpMuArray = [NSMutableArray array];
    }
    return _cpMuArray;
}

- (NSArray *)stArray {
    if (!_stArray) {
        _stArray = [NSMutableArray array];
    }
    return _stArray;
}

- (NSArray *)cpArray {
    if (!_cpArray) {
        _cpArray = [NSMutableArray array];
    }
    return _cpArray;
}

@end
