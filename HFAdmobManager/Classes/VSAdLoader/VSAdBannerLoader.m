//
//  VSAdBannerLoader.m
//  HFAdmobManager
//
//  Created by hf on 2021/5/27.
//

#import "VSAdBannerLoader.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <HFAdmobManager/HFAdmobManager.h>


@interface VSAdBannerLoader ()<GADBannerViewDelegate>


@property (nonatomic, strong) GADBannerView *bannerView;

@property (nonatomic, copy) VSAdBannerLoaderCompletionHandler completionHandler;

@property (nonatomic, assign) VSAdShowPlaceType placeType;

@property (nonatomic, strong) UIViewController *tmpRootController;
@end

@implementation VSAdBannerLoader

- (void)loadAdsWithUnitId:(NSString *)adUnit
                placeType:(VSAdShowPlaceType)placeType
        completionHandler:(VSAdBannerLoaderCompletionHandler)completionHandler {
    
    self.bannerView = [[GADBannerView alloc]
          initWithAdSize:kGADAdSizeBanner];
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bannerView.rootViewController = self.tmpRootController;
    
    // 配置
    self.bannerView.adUnitID = adUnit;
    // 加载
    [self.bannerView loadRequest:[GADRequest request]];
    
    self.bannerView.delegate = self;
    self.completionHandler = completionHandler;
        
    
    self.placeType = placeType;
    [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_startRequest placeType:placeType unitId:adUnit];
}

#pragma mark - GADBannerViewDelegate
#pragma mark Ad Request Lifecycle Notifications
- (void)bannerViewDidReceiveAd:(nonnull GADBannerView *)bannerView {
    bannerView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        bannerView.alpha = 1;
    }];
    
    [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_receiveAd placeType:_placeType unitId:bannerView.adUnitID];
    !self.completionHandler ? nil : self.completionHandler(bannerView, nil);
}

- (void)bannerView:(nonnull GADBannerView *)bannerView
didFailToReceiveAdWithError:(nonnull NSError *)error {
    !self.completionHandler ? nil : self.completionHandler(nil, error);
    [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_receiveAdFail placeType:_placeType unitId:bannerView.adUnitID];
}

- (void)bannerViewDidRecordImpression:(nonnull GADBannerView *)bannerView {
    
}

#pragma mark Click-Time Lifecycle Notifications
- (void)bannerViewWillPresentScreen:(nonnull GADBannerView *)bannerView {
    [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_adShow placeType:_placeType unitId:bannerView.adUnitID];
}

- (void)bannerViewWillDismissScreen:(nonnull GADBannerView *)bannerView {
    
}

- (void)bannerViewDidDismissScreen:(nonnull GADBannerView *)bannerView {
}

- (UIViewController *)tmpRootController {
    if (!_tmpRootController) {
        _tmpRootController = [[UIViewController alloc] init];
    }
    return _tmpRootController;
}
@end
