//
//  VSAdNavLoader.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "VSAdNavLoader.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <HFAdmobManager/HFAdmobManager.h>


@interface VSAdNavLoader()<GADNativeAdLoaderDelegate, GADAdLoaderDelegate>

@property (nonatomic, strong) GADAdLoader *adLoader;

//@property (nonatomic, strong) NSString *adUnitId;
@property (nonatomic, copy) VSAdLoadCompletionHandler loadCompletionHandler;
@property (nonatomic, assign) VSAdShowPlaceType placeType;

@end

@implementation VSAdNavLoader

- (void)loadAdsWithUnitId:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType completionHandler:(VSAdLoadCompletionHandler)completionHandler {
    
    self.adLoader = [self adLoaderWithUnitId:adUnit placeType:placeType];
    GADRequest *request = [GADRequest request];
    self.adLoader.delegate = self;
    [self.adLoader loadRequest:request];
    _placeType = placeType;
    _loadCompletionHandler = completionHandler;
    
    [[HFAdmobManager shareInstance] eventWithEventName:@"start_request" placeType:placeType unitId:adUnit];
}

- (GADAdLoader *)adLoaderWithUnitId:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType {
    GADMultipleAdsAdLoaderOptions *multipleAdsOptions = [[GADMultipleAdsAdLoaderOptions alloc] init];
    multipleAdsOptions.numberOfAds = 1;
    
    // "谷歌广告" 摆放位置
    GADNativeAdViewAdOptions *adViewOptions = [[GADNativeAdViewAdOptions alloc] init];
    adViewOptions.preferredAdChoicesPosition = (placeType == VSAdShowPlaceTypePartHome || placeType == VSAdShowPlaceTypePartOther) ? GADAdChoicesPositionBottomRightCorner : GADAdChoicesPositionTopRightCorner;
    
    // 广告的尺寸
    GADNativeAdMediaAdLoaderOptions *adLoaderOptions = [[GADNativeAdMediaAdLoaderOptions alloc] init];
    adLoaderOptions.mediaAspectRatio = GADMediaAspectRatioPortrait;
    
    GADVideoOptions *adVideoOptions = [[GADVideoOptions alloc] init];
    adVideoOptions.startMuted = YES;
    
    GADNativeMuteThisAdLoaderOptions *muteOptions = [GADNativeMuteThisAdLoaderOptions new];
    GADAdLoader *adLoader = [[GADAdLoader alloc] initWithAdUnitID:adUnit
                                               rootViewController:[UIApplication sharedApplication].keyWindow.rootViewController
                                                          adTypes:@[kGADAdLoaderAdTypeNative]
                                                          options:@[multipleAdsOptions,
                                                                    adViewOptions,
                                                                    adLoaderOptions,
                                                                    adVideoOptions,
                                                                    muteOptions]];
    return adLoader;
}

- (void)updateAds {
    if (self.adLoader.isLoading) {
        HFAd_DebugLog(@"正在加载广告。。。")
        return;
    }
    
    GADRequest *request = [GADRequest request];
#ifdef DEBUG
//    [GoogleMobileAdsMediationTestSuite setAdRequest:request];
#endif
    [self.adLoader loadRequest:request];
}

#pragma mark - GADNativeAdLoaderDelegate
- (void)adLoader:(nonnull GADAdLoader *)adLoader didReceiveNativeAd:(nonnull GADNativeAd *)nativeAd {
    
    self.nativeAd = nativeAd;
    self.isLoadFinish = YES;
    // 用数组存储
    !_loadCompletionHandler ? : _loadCompletionHandler(nativeAd, _placeType, nil);
    
    [[HFAdmobManager shareInstance] eventWithEventName:@"end_request" placeType:_placeType unitId:adLoader.adUnitID];
}

#pragma mark - GADAdLoaderDelegate
/// Called when adLoader fails to load an ad.
- (void)adLoader:(nonnull GADAdLoader *)adLoader
didFailToReceiveAdWithError:(nonnull NSError *)error {
    !_loadCompletionHandler ? : _loadCompletionHandler(nil, _placeType, error);
}

/// Called after adLoader has finished loading.
- (void)adLoaderDidFinishLoading:(nonnull GADAdLoader *)adLoader {
    
}
@end
