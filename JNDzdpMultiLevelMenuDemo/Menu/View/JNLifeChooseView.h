//
//  JNLifeChooseView.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JNLifeChooseView : UIView

@property (nonatomic, copy) void (^typeButtonCallBack)(void);
@property (nonatomic, copy) void (^transButtonCallBack)(void);
- (void)setBgImageStyleWithSpread:(BOOL)listSpread;
- (void)buttonArrowImageStyle:(NSInteger)index listSpread:(BOOL)listSpread;
- (void)buttonTitleWithIndex:(NSInteger)index title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
