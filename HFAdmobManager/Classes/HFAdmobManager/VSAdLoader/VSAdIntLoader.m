//
//  VSAdIntLoader.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "VSAdIntLoader.h"
//#import <VungleAdapter/VungleAdapter.h>
//#import <GoogleMobileAdsMediationTestSuite/GoogleMobileAdsMediationTestSuite.h>



@interface VSAdIntLoader ()<GADInterstitialDelegate>


@property (nonatomic, copy)VSAdIntLoadCompletionHandler loadCompletionHandler;

@end

@implementation VSAdIntLoader

#pragma mark - public
- (void)loadAdsWithUnitId:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType completionHander:(VSAdIntLoadCompletionHandler)completionHandler {
    _loadCompletionHandler = completionHandler;
    self.interstitial = [self interstitialWithAdUnit:adUnit];
//    [VSEventManager logAdsRequestWithPlaceType:placeType unitId:adUnit];
}

#pragma mark - private
- (GADInterstitial *)interstitialWithAdUnit:(NSString *)adUnit {
    GADInterstitial *interstitial =
      [[GADInterstitial alloc] initWithAdUnitID:adUnit];
    interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    [interstitial loadRequest:request];
    

    return interstitial;
}

#pragma mark - GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
    HFAdDebugLog(@"*广告数据* adUnitId(int):%@ %@",ad.adUnitID, ad.responseInfo.adNetworkClassName)

    !_loadCompletionHandler ? : _loadCompletionHandler(ad, nil);
}

- (void)interstitial:(nonnull GADInterstitial *)ad
didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    HFAdDebugLog(@"*广告数据* adUnitId(int):%@, %@", ad.adUnitID, error.debugDescription)
    
    !_loadCompletionHandler ? : _loadCompletionHandler(nil, error);
}

#pragma mark - Display-Time Lifecycle Notifications
- (void)interstitialWillPresentScreen:(nonnull GADInterstitial *)ad {
    
}

- (void)interstitialDidFailToPresentScreen:(nonnull GADInterstitial *)ad {
    
}

- (void)interstitialWillDismissScreen:(nonnull GADInterstitial *)ad {
    
}

- (void)interstitialDidDismissScreen:(nonnull GADInterstitial *)ad {
    
}

- (void)interstitialWillLeaveApplication:(nonnull GADInterstitial *)ad {
    
}
@end
