//
//  CustomViewController.h
//  OCTest

//  编码的方式创建根视图

//  Created by xiaohui on 2018/2/11.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController

@property (nonatomic, copy) void (^TestBlock)(void);

@end
