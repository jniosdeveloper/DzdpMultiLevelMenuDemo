//
//  JNLifeTransSelectModel.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNLifeTransSelectModel.h"

@implementation JNLifeTransSelectModel
- (instancetype)init {
    if (self = [super init]) {
        self.preIndex1 = 0;
        self.preIndex2 = 0;
        self.preIndex3 = -1;
        
        self.index1 = 0;
        self.index2 = 0;
        self.index3 = -1;
        
        self.chooseType = 0;
        
        JNLifeTransModel *transModel = [[JNLifeTransModel alloc] init];
        transModel.title = @"不限";
        transModel.idString = @"";
        self.dataModel = transModel;
    }
    return self;
}
@end
