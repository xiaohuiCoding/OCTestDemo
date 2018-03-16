//
//  ModelA.h
//  OCTest
//
//  Created by xiaohui on 2018/3/15.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+AddMethod.h"
#import "ModelB.h"
#import "ModelC.h"

@interface ModelA : NSObject <ModelDelegate>

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) ModelB *otherInfo;
@property (nonatomic, copy) NSArray<ModelB *> *listB;
@property (nonatomic, copy) NSArray<ModelC *> *listC;

- (void)test;

@end
