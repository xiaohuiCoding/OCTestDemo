//
//  Person.m
//  OCTest
//
//  Created by xiaohui on 2018/2/1.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "Person.h"

@interface Person ()

@end

@implementation Person

- (Person *)initWithName:(NSString *)name gender:(NSString *)gender {
    if (self = [super init]) {
        self.name  = name;
        self.gender = gender;
    }
    return self;
}

+ (Person *)personWithName:(NSString *)name gender:(NSString *)gender {
    return [[self alloc] initWithName:name gender:gender];
}

- (Person *)copyWithZone:(NSZone *)zone {
    Person *person = [[Person allocWithZone:zone] init];
    person.name = [self.name copyWithZone:zone];
    person.gender = [self.gender copyWithZone:zone];
    return person;
}

- (Person *)mutableCopyWithZone:(NSZone *)zone {
    Person *person = [[Person allocWithZone:zone] init];
    person.name = [self.name mutableCopyWithZone:zone];
    person.gender = [self.gender mutableCopyWithZone:zone];
    return person;
}

- (NSUInteger)hash {
    return [self.name hash] ^ [self.gender hash];
}

@end
