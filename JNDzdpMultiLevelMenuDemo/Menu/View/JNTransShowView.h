//
//  JNTransShowView.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//
#import <UIKit/UIKit.h>
#import "JNLifeMenuView.h"
#import "JNLifeTransSelectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JNTransShowView : JNLifeMenuView

@property (nonatomic, copy) void(^dismissCallBack)(JNLifeTransSelectModel *selectModel);

- (instancetype)initWithMenuOriginY:(CGFloat)originY;

- (void)updateSelectState:(JNLifeTransSelectModel *)selectModel;

@end

NS_ASSUME_NONNULL_END
