//
//  NSString+Attributed.m
//  OCTest

//  链式调用设置富文本样式

//  Created by apple on 2022/10/25.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

/*
 模仿 Masonry 库的写法，实现链式调用，代码内聚～
 */

#import "NSString+Attributed.h"

@implementation NSString (Attributed)

- (NSMutableAttributedString *)addAttributes:(void (^)(AttributedMaker * _Nonnull make))attributes {
    AttributedMaker *attributedMaker = [[AttributedMaker alloc] init];
    attributedMaker.attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    attributes(attributedMaker);
    return attributedMaker.attributedString;
}

@end
