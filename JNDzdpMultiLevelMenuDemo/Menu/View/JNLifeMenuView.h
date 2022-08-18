//
//  JNLifeMenuView.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JNLifeMenuView : UIView
- (void)show;
- (void)dismiss;
// 菜单背景被点击
- (void)menuBgDismissTapAction;
@end

NS_ASSUME_NONNULL_END
