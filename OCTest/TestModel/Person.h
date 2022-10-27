//
//  Person.h
//  OCTest
//
//  Created by xiaohui on 2018/2/1.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying, NSMutableCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;

+ (Person *)personWithName:(NSString *)name gender:(NSString *)gender;

- (void)testBlock;

@end
