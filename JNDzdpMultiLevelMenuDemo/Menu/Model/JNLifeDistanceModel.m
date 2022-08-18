//
//  JNLifeDistanceModel.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNLifeDistanceModel.h"

@implementation JNLifeDistanceModel
+ (instancetype)createWithTitle:(NSString *)title distance:(NSString *)distance {
    JNLifeDistanceModel *model = [[JNLifeDistanceModel alloc] init];
    model.title = title;
    model.distance = distance;
    return model;
}
@end
