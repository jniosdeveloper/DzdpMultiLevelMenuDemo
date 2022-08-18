//
//  JNLifeTransModel.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JNLifeTransItem: NSObject

@end

@interface JNLifeTransModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *idString;
@property (nonatomic, assign) BOOL selected;
// 经度
@property (nonatomic, strong) NSString *longitude;
// 纬度
@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSMutableArray<JNLifeTransModel *> *transItems;
@end


NS_ASSUME_NONNULL_END
