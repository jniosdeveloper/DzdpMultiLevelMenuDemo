//
//  JNLifeModuleDataManager.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import "JNLifeShopCategoryModel.h"
#import "JNLifeStationsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JNLifeModuleDataManager : NSObject
+ (NSArray<JNLifeShopCategoryModel *> *)getShopCategoryData;
+ (NSArray<JNLifeStationsModel *> *)getLineStationData;
@end

NS_ASSUME_NONNULL_END
