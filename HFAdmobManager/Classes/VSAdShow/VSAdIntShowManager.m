//
//  VSAdIntShowManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdIntShowManager.h"
#import "VSAdNavTemplateFullScreen.h"

#import "VSAdMacro.h"
#import "VSAdShowClickAdsManager.h"
#import <HFAdmobManager/HFAdmobManager.h>
#import "HFAdsDisplayRatio.h"


@interface VSAdIntShowManager()<GADFullScreenContentDelegate>

@property (nonatomic, assign) VSAdShowPlaceType placeType;

@end

@implementation VSAdIntShowManager

+ (instancetype)shareInstance {
    static VSAdIntShowManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VSAdIntShowManager alloc] init];
    });
    return manager;
}

+ (BOOL)showIntAdWithController:(UIViewController *)viewController placeType:(VSAdShowPlaceType)placeType interstitial:(GADInterstitialAd *)interstitial {
    
    if (![viewController.presentedViewController isKindOfClass:[VSFullScreenAdsController class]]) {
        if ([interstitial canPresentFromRootViewController:viewController error:nil]) {
            [interstitial presentFromRootViewController:viewController];
        } else if ([interstitial canPresentFromRootViewController:viewController.navigationController error:nil]) {
            /// 防止因为层级关系，部分控制器不能弹出 modal控制器
            [interstitial presentFromRootViewController:viewController.navigationController];
        }
        interstitial.fullScreenContentDelegate = [VSAdIntShowManager shareInstance];
        [VSAdIntShowManager shareInstance].placeType = placeType;
        return YES;
    } else {
        return NO;
    }
}

+ (void)closeFullscreenAds {
    UIViewController *vc = [self getTopController];
    if ([NSStringFromClass(vc.class) isEqualToString:@"GADFullScreenAdViewController"]) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    }
}


+ (UIViewController*)getTopController {
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            if (![vc.presentedViewController isKindOfClass:[UIAlertController class]]) {
                vc = vc.presentedViewController;
            } else {
                break;
            }
        }else{
            break;
        }
    }
    return vc;
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
    if ([ad isKindOfClass:[GADInterstitialAd class]]) {
#ifdef DEBUG
        // 统计展示率
        [HFAdsDisplayRatio addShowWithAdPlace:self.placeType unitType:VSAdUnitTypeInt];
#endif
        
        GADInterstitialAd *adData = (GADInterstitialAd *)ad;
        [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_adShow placeType:self.placeType unitId:adData.adUnitID];
    }
}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
//    [VSAdShowClickAdsManager addClickAdsWithPlaceType:self.placeType];
    if ([ad isKindOfClass:[GADInterstitialAd class]]) {
        GADInterstitialAd *adData = (GADInterstitialAd *)ad;
        [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_adHidden placeType:self.placeType unitId:adData.adUnitID];
    }
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

@end
