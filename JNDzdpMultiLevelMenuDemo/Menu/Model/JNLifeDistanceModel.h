//
//  JNLifeDistanceModel.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JNLifeDistanceModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *distance;
+ (instancetype)createWithTitle:(NSString *)title distance:(NSString *)distance;
@end

NS_ASSUME_NONNULL_END
