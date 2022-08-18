//
//  UIButton+common.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageLeft,
    ButtonEdgeInsetsStyleImageRight,
    ButtonEdgeInsetsStyleImageTop,
    ButtonEdgeInsetsStyleImageBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (common)

/// 设置按钮的文字和图片位置
/// @param style 类型
/// @param space 间距
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;


@end

NS_ASSUME_NONNULL_END
