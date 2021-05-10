//
//  VSAdNavLoader.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@class GADNativeAd;
typedef void(^VSAdLoadCompletionHandler)(GADNativeAd * _Nullable nativeAd, VSAdShowPlaceType placeType, NSError *_Nullable error);

@interface VSAdNavLoader : NSObject

@property (nonatomic, strong) GADNativeAd *nativeAd;
@property (nonatomic, assign) BOOL isLoadFinish;
- (void)loadAdsWithUnitId:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType completionHandler:(VSAdLoadCompletionHandler)completionHandler;


@end

NS_ASSUME_NONNULL_END
