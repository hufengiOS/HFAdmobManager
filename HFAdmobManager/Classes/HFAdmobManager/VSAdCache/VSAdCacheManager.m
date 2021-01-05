//
//  VSAdCacheManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/24.
//

#import "VSAdCacheManager.h"
#import "NSArray+Map.h"
#import "VSAdConfig.h"


//static nsinterger

@interface VSAdCacheManager ()

@property (nonatomic, strong) NSMutableArray<VSAdCacheData *> *cahceArray;


@end

@implementation VSAdCacheManager

+ (instancetype)shareInstance {
    static VSAdCacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VSAdCacheManager alloc] init];
        manager.cahceArray = [[NSMutableArray alloc] init];
    });
    return manager;
}

+ (void)saveAdsWithAdsType:(VSAdUnitType)unitType placeType:(VSAdShowPlaceType)placeType adUnitId:(NSString *)adUnitId adWeight:(float)adWeigth obj:(id)obj {
    VSAdCacheManager *manager = [self shareInstance];
    VSAdCacheData *data = [VSAdCacheData cacheDataWithUnitType:unitType placeType:placeType adUnitId:adUnitId adWeight:adWeigth obj:obj];
    @synchronized (manager.cahceArray) {
        [manager.cahceArray addObject:data];
        HFAdDebugLog(@"广告管理添加 %@ 剩余%ld", data.description, manager.cahceArray.count)
    }
}

+ (VSAdCacheData *)adsWithPlaceType:(VSAdShowPlaceType)placeType {
    return [self adsWithPlaceType:placeType allowShare:YES];
}

+ (VSAdCacheData *)adsWithPlaceType:(VSAdShowPlaceType)placeType allowShare:(BOOL)allowShare {
    VSAdCacheManager *manager = [self shareInstance];
    NSArray *array = [manager.cahceArray myFilter:^BOOL(VSAdCacheData  * _Nonnull obj) {
        if (allowShare) {
            if (placeType == VSAdShowPlaceTypePartHome || placeType == VSAdShowPlaceTypePartOther) {
                return obj.placeType == VSAdShowPlaceTypePartOther || obj.placeType == VSAdShowPlaceTypePartHome;
            } else if (placeType == VSAdShowPlaceTypeFullStart || placeType == VSAdShowPlaceTypeFullConnect || placeType == VSAdShowPlaceTypeFullExtra) {
                return obj.placeType == VSAdShowPlaceTypeFullStart || obj.placeType == VSAdShowPlaceTypeFullConnect || obj.placeType == VSAdShowPlaceTypeFullExtra;
            } else {
                return NO;
            }
        } else {
            return obj.placeType == placeType;
        }
    }];
    
    array = [array sortedArrayUsingComparator:^NSComparisonResult(VSAdCacheData  *_Nonnull obj1, VSAdCacheData  *_Nonnull obj2) {
        return obj1.adWeight > obj2.adWeight;
    }];
    return array.firstObject;
}

+ (void)removeAdsWithData:(VSAdCacheData *)data {
    VSAdCacheManager *manager = [self shareInstance];
//    [manager.cahce removeObjectForKey];
//    [manager.cahce removeObjectForKey:data.cacheKey];
    @synchronized (manager.cahceArray) {
        [manager.cahceArray removeObject:data];
        HFAdDebugLog(@"广告管理移除 %@ 剩余%ld", data.description, manager.cahceArray.count)
    }
}

@end


@implementation VSAdCacheData

+ (VSAdCacheData *)cacheDataWithUnitType:(VSAdUnitType)unitType
                               placeType:(VSAdShowPlaceType)placeType
                                adUnitId:(NSString *)adUnitId
                                adWeight:(float)adWeight
                                     obj:(id)obj {
    VSAdCacheData *data = [[VSAdCacheData alloc] init];
    data.unitType = unitType;
    data.placeType = placeType;
    data.adWeight = adWeight;
    data.adUnitId = adUnitId;
    data.obj = obj;
    return data;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ adWeight = %lf obj = %@", [VSAdConfig nameWithUnitType:_unitType], [VSAdConfig nameWithPlaceType:_placeType], self.adWeight, self.obj];
}



//- (NSString *)cacheKey {
//    return [NSString stringWithFormat:@"%ld-%ld-%lf", self.unitType , self.placeType, self.adWeight];
//}
//
//- (NSString *)cacheKeyForObj:(id)obj {
//    
//    return @"";
//}
@end
