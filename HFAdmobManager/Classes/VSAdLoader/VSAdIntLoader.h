//
//  VSAdIntLoader.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@class GADInterstitialAd;
typedef void(^VSAdIntLoadCompletionHandler)(GADInterstitialAd * _Nullable interstitial, NSError * _Nullable error);

@interface VSAdIntLoader : NSObject

@property (nonatomic, strong, nullable) GADInterstitialAd *interstitial;

- (void)loadAdsWithUnitId:(NSString *)adUnit
                placeType:(VSAdShowPlaceType)placeType
         completionHander:(VSAdIntLoadCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
