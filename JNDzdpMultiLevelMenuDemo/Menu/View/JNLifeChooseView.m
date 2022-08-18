//
//  JNLifeChooseView.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNLifeChooseView.h"
#import "UIImage+common.h"
#import "UIButton+common.h"
#import "UIColor+common.h"

@interface JNLifeChooseView()

@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIButton *transButton;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic, strong) NSArray<UIButton *> *buttonArray;
@property (nonatomic, strong) UIImage *bgImage1;
@property (nonatomic, strong) UIImage *bgImage2;

@end

@implementation JNLifeChooseView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImage1 = [UIImage jn_imageByColor:UIColor.whiteColor cornerRadius:20.0 corners:UIRectCornerAllCorners];
    self.bgImage2 = [UIImage jn_imageByColor:UIColor.whiteColor cornerRadius:20.0 corners:UIRectCornerTopLeft|UIRectCornerTopRight];
    
    self.bgImageView.image = self.bgImage1;
    
    self.buttonArray = @[self.typeButton,self.transButton];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.typeButton layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleImageRight) imageTitlespace:2];
    [self.transButton layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleImageRight) imageTitlespace:2];
}
- (IBAction)clickTypeButton:(id)sender {
    if (self.typeButtonCallBack) {
        self.typeButtonCallBack();
    }
}
- (IBAction)clickTransButton:(id)sender {
    if (self.transButtonCallBack) {
        self.transButtonCallBack();
    }
}
- (void)setBgImageStyleWithSpread:(BOOL)listSpread {
    if (listSpread) {
        self.bgImageView.image = self.bgImage2;
    } else {
        self.bgImageView.image = self.bgImage1;
    }
}
- (void)buttonArrowImageStyle:(NSInteger)index listSpread:(BOOL)listSpread {
    for (UIButton *button in self.buttonArray) {
        [button setImage:[UIImage imageNamed:@"life_arrow_down"] forState:UIControlStateNormal];
    }
    if (listSpread) {
        if (index < self.buttonArray.count) {
            UIButton *button = self.buttonArray[index];
            [button setImage:[UIImage imageNamed:@"life_arrow_up"] forState:UIControlStateNormal];
        }
    }
}
- (void)buttonTitleWithIndex:(NSInteger)index title:(NSString *)title {
    if (index < self.buttonArray.count) {
        UIButton *button = self.buttonArray[index];
        [button setTitle:title forState:UIControlStateNormal];
        if ([title isEqualToString:@"全部类型"] || [title isEqualToString:@"不限"]) {
            [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            if ([title isEqualToString:@"全部类型"]) {
                [button setTitle:@"全部类型" forState:UIControlStateNormal];
            }
            if ([title isEqualToString:@"不限"]) {
                [button setTitle:@"距离/地铁" forState:UIControlStateNormal];
            }
        } else {
            [button setTitleColor:[UIColor colorWithHexString:@"#DB880A"] forState:UIControlStateNormal];
        }
        [button layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyleImageRight) imageTitlespace:2];
    }
    
}
@end
