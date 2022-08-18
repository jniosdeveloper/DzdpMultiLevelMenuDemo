//
//  JNTypeShowView.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNLifeMenuView.h"
#import "JNLifeShopCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JNTypeShowView : JNLifeMenuView
@property (nonatomic, copy) void(^dismissCallBack)(JNLifeShopCategoryModel *selectModel);
- (instancetype)initWithMenuOriginY:(CGFloat)originY dataSource:(NSArray *)dataSource;
- (void)updateSelectState:(JNLifeShopCategoryModel *)selectModel;
@end

NS_ASSUME_NONNULL_END
