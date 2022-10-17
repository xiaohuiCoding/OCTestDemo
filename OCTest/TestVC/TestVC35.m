//
//  TestVC35.m
//  OCTest

//  逆向 混淆

//  Created by Apple on 2021/12/1.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

/*
 https://zhuanlan.zhihu.com/p/146021168（代码混淆）
 */

#import "TestVC35.h"

@interface TestVC35 ()

@end

@implementation TestVC35

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 对三方开源项目进行更改并用cocoapods集成到项目里
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.xh_tag = @"xiaohui";
    NSLog(@"%@",manager.xh_tag);
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

/*
 执行pod install时遇到了一个报错，如下：
 [!] CocoaPods could not find compatible versions for pod "AFNetworking":
   In Podfile:
     AFNetworking (from `https://github.com/xiaohuiCoding/AFNetworking`)

 Specs satisfying the `AFNetworking (from `https://github.com/xiaohuiCoding/AFNetworking`)` dependency were found, but they required a higher minimum deployment target.

 报错原因：podfile里面设置的target版本过低，调整下就可以了～
 */
