//
//  AttributedMaker.h
//  OCTest

//  富文本样式中间者

//  Created by apple on 2022/10/25.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttributedMaker : NSObject

@property (nonatomic, strong) NSMutableAttributedString *attributedString;

// 设置字号大小
- (AttributedMaker *(^)(UIFont *value))font;
// 段落样式
- (AttributedMaker *(^)(NSMutableParagraphStyle *value))paragraphStyle;
// 设置文字颜色
- (AttributedMaker *(^)(UIColor *value))foregroundColor;
// 设置背景颜色
- (AttributedMaker *(^)(UIColor *value))backgroundColor;
// 设置斜体
- (AttributedMaker *(^)(float value))obliqueness;
// 删除线高度
- (AttributedMaker *(^)(NSInteger value))strikethroughStyle;
// 删除线颜色
- (AttributedMaker *(^)(UIColor *value))strikethroughColor;
// 下滑线粗度
- (AttributedMaker *(^)(NSInteger value))underlineStyle;
// 下滑线颜色
- (AttributedMaker *(^)(UIColor *value))underlineColor;
// 字体描边宽度
- (AttributedMaker *(^)(float value))strokeWidth;
// 字体描边颜
- (AttributedMaker *(^)(UIColor *value))strokeColor;
// 字体阴影
- (AttributedMaker *(^)(NSShadow *value))shadow;
// 字间距
- (AttributedMaker *(^)(float value))kern;
// 行间距
- (AttributedMaker *(^)(float value))lineSpacing;
// 对齐方式
- (AttributedMaker *(^)(NSTextAlignment value))textAlignment;
// 字符截断类型
- (AttributedMaker *(^)(NSLineBreakMode value))lineBreakMode;
// 设置URL跳转（仅UITextView 有效，UILabel 和 UITextField里面无效！）
- (AttributedMaker *(^)(NSString *value))link;
// 插入图片(图片，尺寸，位置)
- (AttributedMaker *(^)(UIImage *image,CGRect bounds,NSInteger index))insertImage;
// 追加文字
- (AttributedMaker *(^)(NSString *string))append;
// 合并（例如追加完文字以后，来个总设置）
- (AttributedMaker *)merge;

@end

NS_ASSUME_NONNULL_END
