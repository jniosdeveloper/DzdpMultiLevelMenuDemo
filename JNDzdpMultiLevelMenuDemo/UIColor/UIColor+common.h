//
//  UIColor+common.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (common)
/// 根据十六进制颜色字符串设置颜色
/// @param color 十六进制颜色字符串
+ (UIColor *)colorWithHexString:(NSString *)color;

/// 根据十六进制颜色字符串设置颜色
/// @param color 十六进制颜色字符串
/// @param alpha 颜色透明度
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
