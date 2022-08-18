//
//  JNLifeShopCategoryModel.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JNLifeShopCategoryModel : NSObject
@property (nonatomic, strong) NSString *categoryCode;
@property (nonatomic, strong) NSString *categoryName;
// 是否选中
@property (nonatomic, assign) BOOL select;
@end

NS_ASSUME_NONNULL_END
