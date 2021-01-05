//
//  VSAdCacheManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSAdCacheData : NSObject
@property (nonatomic, assign) VSAdUnitType unitType;
@property (nonatomic, assign) VSAdShowPlaceType placeType;
@property (nonatomic, assign) float adWeight;
@property (nonatomic, strong) NSString *adUnitId;
@property (nonatomic, strong) id obj;


//- (NSString *)cacheKey;
+ (VSAdCacheData *)cacheDataWithUnitType:(VSAdUnitType)unitType placeType:(VSAdShowPlaceType)placeType adUnitId:(NSString *)adUnitId adWeight:(float)adWeight obj:(id)obj;

@end


@interface VSAdCacheManager : NSObject

+ (void)saveAdsWithAdsType:(VSAdUnitType)unitType placeType:(VSAdShowPlaceType)placeType adUnitId:(NSString *)adUnitId adWeight:(float)adWeigth obj:(id)obj;

+ (VSAdCacheData *)adsWithPlaceType:(VSAdShowPlaceType)placeType;
+ (VSAdCacheData *)adsWithPlaceType:(VSAdShowPlaceType)placeType allowShare:(BOOL)allowShare;
+ (void)removeAdsWithData:(VSAdCacheData *)data;

@end



NS_ASSUME_NONNULL_END
