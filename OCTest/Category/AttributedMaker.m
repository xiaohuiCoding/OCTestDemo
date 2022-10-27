//
//  AttributedMaker.m
//  OCTest

//  富文本样式中间者

//  Created by apple on 2022/10/25.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "AttributedMaker.h"

@implementation AttributedMaker

- (AttributedMaker * _Nonnull (^)(UIFont * _Nonnull))font {
    return ^(UIFont *font) {
        [self.attributedString addAttribute:NSFontAttributeName
                                      value:font
                                      range:NSMakeRange(0, self.attributedString.length)];
        return self;
    };
}

- (AttributedMaker * _Nonnull (^)(NSMutableParagraphStyle * _Nonnull))paragraphStyle {
    return ^(NSMutableParagraphStyle *paragraphStyle) {
        [self.attributedString addAttribute:NSParagraphStyleAttributeName
                                      value:paragraphStyle
                                      range:NSMakeRange(0, self.attributedString.length)];
        return self;
    };
}

- (AttributedMaker * _Nonnull (^)(UIColor * _Nonnull))foregroundColor {
    return ^(UIColor *foregroundColor) {
        [self.attributedString addAttribute:NSForegroundColorAttributeName
                                      value:foregroundColor
                                      range:NSMakeRange(0, self.attributedString.length)];
        return self;
    };
}

- (AttributedMaker * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^(UIColor *backgroundColor) {
        [self.attributedString addAttribute:NSBackgroundColorAttributeName
                                      value:backgroundColor
                                      range:NSMakeRange(0, self.attributedString.length)];
        return self;
    };
}

- (AttributedMaker * _Nonnull (^)(float))obliqueness {
    return ^(float obliqueness) {
        [self.attributedString addAttribute:NSObliquenessAttributeName
                                      value:@(obliqueness)
                                      range:NSMakeRange(0, self.attributedString.length)];
        return self;
    };
}

@end
