//
//  UIView+common.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (common)
/// 从XIB中实例化对象
+ (instancetype)instanceFromNib;

/// 获取NIB对象
+ (UINib *)nib;

/// 获取重用字符串
+ (NSString *)cellReuseIdentifier;

- (void)addRoundedCorners:(UIRectCorner)corners withRadius:(CGSize)radius;

@property (assign, nonatomic) CGFloat jn_width;
@property (assign, nonatomic) CGFloat jn_height;
@property (assign, nonatomic) CGFloat jn_x;
@property (assign, nonatomic) CGFloat jn_y;
@property (assign, nonatomic) CGFloat jn_centerX;
@property (assign, nonatomic) CGFloat jn_centerY;
@property (assign, nonatomic) CGFloat jn_right;
@end

NS_ASSUME_NONNULL_END
