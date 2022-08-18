//
//  JNLifeTransSelectModel.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import "JNLifeTransModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JNLifeTransSelectModel : NSObject
@property (nonatomic, assign) NSInteger preIndex1;
@property (nonatomic, assign) NSInteger preIndex2;
@property (nonatomic, assign) NSInteger preIndex3;
@property (nonatomic, assign) NSInteger index1;
@property (nonatomic, assign) NSInteger index2;
@property (nonatomic, assign) NSInteger index3;
@property (nonatomic, strong) JNLifeTransModel *dataModel;
// 选中的类型 0距离 1站点
@property (nonatomic, assign) NSInteger chooseType;
@end

NS_ASSUME_NONNULL_END
