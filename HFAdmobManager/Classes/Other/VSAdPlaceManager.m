//
//  VSAdPlaceManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/25.
//

#import "VSAdPlaceManager.h"
#import "VSAdNavLoader.h"
#import "VSAdIntLoader.h"
#import "VSAdBannerLoader.h"
#import "VSAdCacheManager.h"
#import "VSGlobalConfigManager.h"
#import "VSAdConfig.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

#import <HFAdmobManager/HFAdmobManager.h>
#import "VSAdBannerShowManager.h"


/*
 横幅广告                   ca-app-pub-3940256099942544/2934735716
 插页式广告                 ca-app-pub-3940256099942544/4411468910
 插页式视频广告              ca-app-pub-3940256099942544/5135589807
 激励视频广告                 ca-app-pub-3940256099942544/1712485313
 原生高级广告                 ca-app-pub-3940256099942544/3986624511
 原生高级视频广告              ca-app-pub-3940256099942544/2521693316
 */

@interface VSAdPlaceManager ()
@property (nonatomic, strong) VSAdNavLoader *navLoader;
@property (nonatomic, strong) VSAdIntLoader *intLoader;

@property (nonatomic, strong) VSAdBannerLoader *bannerLoader;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation VSAdPlaceManager


#pragma mark - public
// 传递数组进来加载
- (void)loadAdsWithPlaceType:(VSAdShowPlaceType)placeType completionHandler:(void (^ _Nullable)(BOOL success))completionHandler {
    VSAdCacheData *data = [VSAdCacheManager adsWithPlaceType:placeType allowShare:NO];
    if (data) {
        !completionHandler ? : completionHandler(YES);
    } else {
        VSGlobalConfigManager *globalConfig = [VSGlobalConfigManager shareInstance];
        NSArray <VSGlobalConfigAdsConfigAdPlaceModel *> *adPlaceArray = [globalConfig adPlacesWithPlaceType:placeType];
        // 加载第一个
        [self loadAdsWithConfigArray:adPlaceArray
                               index:0
                           placeType:placeType
                         containView:nil
                      rootController:nil
                   completionHandler:^(BOOL success) {
            !completionHandler ? : completionHandler(success);
        }];
    }
}

- (void)loadBannerAdsWithPlaceType:(VSAdShowPlaceType)placeType
                       containView:(UIView * _Nullable)containView
                    rootController:(UIViewController *)rootController
                 completionHandler:(void (^ _Nullable)(BOOL success))completionHandler {
    VSAdCacheData *data = [VSAdCacheManager adsWithPlaceType:placeType allowShare:NO];
    if (data) {
        !completionHandler ? : completionHandler(YES);
    } else {
        VSGlobalConfigManager *globalConfig = [VSGlobalConfigManager shareInstance];
        NSArray <VSGlobalConfigAdsConfigAdPlaceModel *> *adPlaceArray = [globalConfig adPlacesWithPlaceType:placeType];
        // 加载第一个
        [self loadAdsWithConfigArray:adPlaceArray
                               index:0
                           placeType:placeType
                         containView:containView
                      rootController:rootController
                   completionHandler:^(BOOL success) {
            !completionHandler ? : completionHandler(success);
        }];
    }
}

/// 依次加载广告
- (void)loadAdsWithConfigArray:(NSArray<VSGlobalConfigAdsConfigAdPlaceModel *> *)configArray
                         index:(NSInteger)index
                     placeType:(VSAdShowPlaceType)placeType
                   containView:(UIView * _Nullable)containView
                rootController:(UIViewController *_Nullable)rootController
             completionHandler:(void (^ _Nullable)(BOOL success)) completionHandler {
    
    if (index < configArray.count && [VSAdConfig allowRequestWithShowPlaceType:placeType]) {
        if (!self.isLoading) {
            self.isLoading = YES;
            VSGlobalConfigAdsConfigAdPlaceModel *configModel = configArray[index];
            
            __weak typeof(self) weakself = self;
            __block NSInteger currentIndex = index;
            [self loadAdsWithAdUnit:configModel.adPlaceID
                               type:configModel.adUnitType
                        containView:containView
                     rootController:rootController
                           adWeight:configModel.adWeight
                          placeType:placeType
                  completionHandler:^(BOOL success) {
                currentIndex ++;
                if (!success) {
                    [weakself loadAdsWithConfigArray:configArray
                                               index:currentIndex
                                           placeType:placeType
                                         containView:containView
                                      rootController:rootController
                                   completionHandler:completionHandler];
                } else {
                    !completionHandler ? : completionHandler(success);
                    weakself.isLoading = NO;
                }
            }];
        }
    } else {
        // 加载失败
        !completionHandler ? : completionHandler(NO);
    }
}

- (void)loadAdsWithAdUnit:(NSString *)adUnit
                     type:(VSAdUnitType)type
              containView:(UIView * _Nullable)containView
           rootController:(UIViewController * _Nullable)rootController
                 adWeight:(float)adWeight
                placeType:(VSAdShowPlaceType)placeType
        completionHandler:(void (^)(BOOL success)) completionHandler {
    if (type == VSAdUnitTypeNav) {
        if ([HFAdmobManager shareInstance].isDEBUGMode) {
            adUnit = @"ca-app-pub-3940256099942544/3986624511";
        }
        [self.navLoader loadAdsWithUnitId:adUnit placeType:placeType completionHandler:^(GADNativeAd * _Nullable nativeAd, VSAdShowPlaceType placeType, NSError * _Nullable error) {
            if (nativeAd) {
                [VSAdCacheManager saveAdsWithAdsType:type placeType:placeType adUnitId:adUnit adWeight:adWeight obj:nativeAd];
            }
            !completionHandler ? : completionHandler(nativeAd != nil);
        }];
    } else if (type == VSAdUnitTypeInt) {
        if ([HFAdmobManager shareInstance].isDEBUGMode) {
            adUnit = @"ca-app-pub-3940256099942544/4411468910";
        }
        [self.intLoader loadAdsWithUnitId:adUnit placeType:placeType completionHander:^(GADInterstitialAd * _Nullable interstitial, NSError * _Nullable error) {
            if (!error) {
                [VSAdCacheManager saveAdsWithAdsType:type placeType:placeType adUnitId:adUnit adWeight:adWeight obj:interstitial];
            }
            !completionHandler ? : completionHandler(!error);
        }];
    } else if (type == VSAdUnitTypeBanner) {
        if ([HFAdmobManager shareInstance].isDEBUGMode) {
            adUnit = @"ca-app-pub-3940256099942544/2934735716";
        }
        [self.bannerLoader loadAdsWithUnitId:adUnit
                                 containView:containView
                              rootController:rootController
                                   placeType:placeType
                           completionHandler:^(GADBannerView * _Nullable bannerView, NSError * _Nullable error) {
            [VSAdBannerShowManager showAdWithContainView:containView placeType:placeType bannerView:bannerView];
            !completionHandler ? : completionHandler(!error);
        }];
        
    } else {
        NSAssert(YES, @"广告类型不支持");
        !completionHandler ? : completionHandler(NO);
    }
}

- (BOOL)isloadFinish {
    return nil != self.intLoader.interstitial;
}

#pragma mark - lazy
- (VSAdNavLoader *)navLoader {
    if (!_navLoader) {
        _navLoader = [[VSAdNavLoader alloc] init];
    }
    return _navLoader;
}

- (VSAdIntLoader *)intLoader {
    if (!_intLoader) {
        _intLoader = [[VSAdIntLoader alloc] init];
    }
    return _intLoader;
}

- (VSAdBannerLoader *)bannerLoader {
    if (!_bannerLoader) {
        _bannerLoader = [[VSAdBannerLoader alloc] init];
    }
    return _bannerLoader;
}
@end
