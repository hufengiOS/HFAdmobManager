//
//  VSAdNavTemplateFullScreen.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSAdNavTemplateFullScreen : VSAdNavTemplateBase

- (void)showInController:(UIViewController *)controller placeType:(VSAdShowPlaceType)placeType nativeAd:(GADNativeAd *)nativeAd;
- (void)closeFullscreenAds;

@end


@interface VSFullScreenAdsController : UIViewController
@end

NS_ASSUME_NONNULL_END
