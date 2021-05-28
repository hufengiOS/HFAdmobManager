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

@end

@implementation VSAdBannerLoader

- (void)loadAdsWithUnitId:(NSString *)adUnit
              containView:(UIView * _Nullable)containView
           rootController:(UIViewController *)rootController
                placeType:(VSAdShowPlaceType)placeType
        completionHandler:(VSAdBannerLoaderCompletionHandler)completionHandler {
    
    self.bannerView = [[GADBannerView alloc]
          initWithAdSize:kGADAdSizeBanner];
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    // 配置
    self.bannerView.adUnitID = adUnit;
    NSAssert(rootController, @"必须设置rootController 否则拉不到banner广告");
    self.bannerView.rootViewController = rootController;
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
@end
