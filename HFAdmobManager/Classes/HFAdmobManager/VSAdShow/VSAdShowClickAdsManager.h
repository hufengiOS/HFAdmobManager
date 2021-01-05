//
//  VSAdShowClickAdsManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/27.
//

#import <Foundation/Foundation.h>

#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSAdShowClickAdsManager : NSObject

/// 管理广告点击次数
+ (NSInteger)numberOfClickAdsWithPlaceType:(VSAdShowPlaceType)placeType;
+ (void)cleanNumberOfClickAdsWithPlaceType:(VSAdShowPlaceType)placeType;
+ (NSInteger)addClickAdsWithPlaceType:(VSAdShowPlaceType)placeType;

#pragma mark - 广告展示次数的限制
+ (NSInteger)numberOfShowAdsWithPlaceType:(VSAdShowPlaceType)placeType;
+ (void)cleanNumberOfShowAdsWithPlaceType:(VSAdShowPlaceType)placeType;
+ (NSInteger)addNumberOfShowAdsWithPlaceType:(VSAdShowPlaceType)placeType;


+ (BOOL)allowClickWithPlaceType:(VSAdShowPlaceType)placeType;
@end

NS_ASSUME_NONNULL_END
