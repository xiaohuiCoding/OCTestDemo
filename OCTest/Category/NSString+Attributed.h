//
//  NSString+Attributed.h
//  OCTest

//  链式调用设置富文本样式

//  Created by apple on 2022/10/25.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributedMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Attributed)

- (NSMutableAttributedString *)addAttributes:(void (^)(AttributedMaker * _Nonnull make))attributes;

@end

NS_ASSUME_NONNULL_END
