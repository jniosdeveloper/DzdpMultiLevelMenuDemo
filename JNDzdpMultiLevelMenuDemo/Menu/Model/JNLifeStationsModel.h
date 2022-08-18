//
//  JNLifeStationsModel.h
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface JNLifeStationItem : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
// 经度
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@end

@interface JNLifeStationsModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<JNLifeStationItem *> *stationInfos;
@end




NS_ASSUME_NONNULL_END
