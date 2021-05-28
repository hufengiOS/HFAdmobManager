//
//  VSAdCacheManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/24.
//

#import "VSAdCacheManager.h"
#import "VSAdConfig.h"
#import "VSAdUnit.h"

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
    };
}

+ (VSAdCacheData *)adsWithPlaceType:(VSAdShowPlaceType)placeType {
    return [self adsWithPlaceType:placeType allowShare:YES];
}


/// 获取广告数据
/// @param placeType 广告位
/// @param allowShare 是否允许广告位共享
+ (VSAdCacheData *)adsWithPlaceType:(VSAdShowPlaceType)placeType
                         allowShare:(BOOL)allowShare {
    VSAdCacheManager *manager = [self shareInstance];
    
    NSArray *array = [VSAdUnit hf_sourceArray:manager.cahceArray filter:^BOOL(VSAdCacheData * _Nonnull element) {
        if (allowShare && placeType != VSAdShowPlaceTypeBanner) {
            if (placeType == VSAdShowPlaceTypePartHome ||
                placeType == VSAdShowPlaceTypePartOther) {
                return element.placeType == VSAdShowPlaceTypePartOther ||
                element.placeType == VSAdShowPlaceTypePartHome;
            } else if (placeType == VSAdShowPlaceTypeFullStart ||
                       placeType == VSAdShowPlaceTypeFullConnect ||
                       placeType == VSAdShowPlaceTypeFullExtra) {
                return element.placeType == VSAdShowPlaceTypeFullStart ||
                element.placeType == VSAdShowPlaceTypeFullConnect ||
                element.placeType == VSAdShowPlaceTypeFullExtra;
            } else {
                return NO;
            }
        } else {
            return element.placeType == placeType;
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
    };
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
    return [NSString stringWithFormat:@"%@ %@ adWeight = %lf obj = %@", ADUnitTypeString(_unitType), ADPlaceTypeString(_placeType), self.adWeight, self.obj];    
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
