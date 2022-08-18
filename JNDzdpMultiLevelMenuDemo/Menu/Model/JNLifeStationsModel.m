//
//  JNLifeStationsModel.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNLifeStationsModel.h"

@implementation JNLifeStationsModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"ID": @"id"
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"stationInfos": [JNLifeStationItem class]};
}
#pragma mark - Obj Func
- (void)encodeWithCoder:(NSCoder *)coder {
    [self yy_modelEncodeWithCoder:coder];
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    return [self yy_modelInitWithCoder:coder];
}
@end


@implementation JNLifeStationItem

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"ID": @"id"
             };
}
@end
