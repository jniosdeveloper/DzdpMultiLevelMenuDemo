//
//  UIImage+common.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (common)
+ (UIImage *)jn_imageByColor:(UIColor *)color cornerRadius:(CGFloat)radius corners:(UIRectCorner)corners;
@end

NS_ASSUME_NONNULL_END
