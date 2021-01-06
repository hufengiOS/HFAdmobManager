//
//  VSAdIntLoader.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@class GADInterstitial;
typedef void(^VSAdIntLoadCompletionHandler)(GADInterstitial * _Nullable interstitial, NSError * _Nullable error);

@interface VSAdIntLoader : NSObject

@property (nonatomic, strong) GADInterstitial *interstitial;

- (void)loadAdsWithUnitId:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType completionHander:(VSAdIntLoadCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
