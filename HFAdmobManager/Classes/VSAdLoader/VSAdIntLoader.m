//
//  VSAdIntLoader.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "VSAdIntLoader.h"
//#import <VungleAdapter/VungleAdapter.h>
//#import <GoogleMobileAdsMediationTestSuite/GoogleMobileAdsMediationTestSuite.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <HFAdmobManager/HFAdmobManager.h>


@interface VSAdIntLoader ()<GADFullScreenContentDelegate>


@property (nonatomic, copy) VSAdIntLoadCompletionHandler loadCompletionHandler;
@property (nonatomic, assign) VSAdShowPlaceType placeType;

@end

@implementation VSAdIntLoader

#pragma mark - public
- (void)loadAdsWithUnitId:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType completionHander:(VSAdIntLoadCompletionHandler)completionHandler {
    _loadCompletionHandler = completionHandler;
    
    GADRequest *request = [GADRequest request];
    __weak typeof(self) weakself = self;
    [GADInterstitialAd loadWithAdUnitID:adUnit request:request completionHandler:^(GADInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        if (error) {
            !weakself.loadCompletionHandler ? : weakself.loadCompletionHandler(nil, error);
            weakself.interstitial = nil;
        } else {
            weakself.interstitial = interstitialAd;
            weakself.interstitial.fullScreenContentDelegate = weakself;
            !weakself.loadCompletionHandler ? : weakself.loadCompletionHandler(interstitialAd, nil);
        }
    }];
    
    self.placeType = placeType;
    [[HFAdmobManager shareInstance] eventWithEventName:@"start_request" placeType:placeType unitId:adUnit];
}

#pragma mark - GADFullScreenContentDelegate
/// Tells the delegate that an impression has been recorded for the ad.
- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    
}

/// Tells the delegate that the ad presented full screen content.
- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

@end
