//
//  TestVC34.m
//  OCTest

//  KVC

//  Created by Apple on 2021/11/24.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import "TestVC34.h"

/*
 KVC就是指iOS的开发中，可以允许开发者通过Key名直接访问对象的属性，或者给对象的属性赋值。而不需要调用明确的存取方法。这样就可以在运行时动态地访问和修改对象的属性。而不是在编译时确定，这也是iOS开发中的黑魔法之一。很多高级的iOS开发技巧都是基于KVC实现的

 参考：https://www.jianshu.com/p/e70bac443cf2
 */

@interface TestVC34 ()

@end

@implementation TestVC34

/*
 // 几种基本方法
- (id)valueForKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

 // 若让一个类禁用KVC，就重写这个方法(原理：如果KVC没有找到set<Key>:属性名时，会直接用setValue：forUndefinedKey：方法)
+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
