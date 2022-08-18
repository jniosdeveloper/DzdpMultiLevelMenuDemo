//
//  JNLifeModuleDataManager.m
//  JNDzdpMultiLevelMenuDemo
//
//  Created by jackie-pc on 2022/8/18.
//

#import "JNLifeModuleDataManager.h"

@implementation JNLifeModuleDataManager
+ (NSArray<JNLifeShopCategoryModel *> *)getShopCategoryData {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShopCategory" ofType:@"json"]];
    NSDictionary *tempDict = [self dictionaryWithJSON:JSONData];
    NSArray<JNLifeShopCategoryModel *> *localData = [NSArray yy_modelArrayWithClass:JNLifeShopCategoryModel.class json:tempDict[@"data"]];
    return localData;
}
+ (NSArray<JNLifeStationsModel *> *)getLineStationData {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LineStations" ofType:@"json"]];
    NSDictionary *tempDict = [self dictionaryWithJSON:JSONData];
    NSArray<JNLifeStationsModel *> *localData = [NSArray yy_modelArrayWithClass:JNLifeStationsModel.class json:tempDict[@"data"]];
    return localData;
}
+ (NSDictionary *)dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}
@end
