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


@interface VSAdIntShowManager()<GADInterstitialDelegate>

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

+ (BOOL)showIntAdWithController:(UIViewController *)viewController placeType:(VSAdShowPlaceType)placeType interstitial:(GADInterstitial *)interstitial {
    
    if ([interstitial canPresentFromRootViewController:viewController error:nil] && ![viewController.presentedViewController isKindOfClass:[VSFullScreenAdsController class]]) {
        [interstitial presentFromRootViewController:viewController];
        interstitial.delegate = [VSAdIntShowManager shareInstance];
        [VSAdIntShowManager shareInstance].placeType = placeType;
        
        return YES;
    } else {
        return NO;
    }
}

//+ (void)closeIntAdsWithInterstitial:(GADInterstitial *)interstitial {
//    NSError *error;
//    if (![interstitial canPresentFromRootViewController:kKeyWindow.rootViewController error:&error]) {
//        if ([NSStringFromClass(vc.class) isEqualToString:@"GADFullScreenAdViewController"]) {
//            [vc dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
//}

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

#pragma mark - GADInterstitialDelegate
#pragma mark Ad Request Lifecycle Notifications
- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
//    [VSEventManager logAdsMatchWithPlaceType:self.placeType unitId:ad.adUnitID];
    [[HFAdmobManager shareInstance] eventWithEventName:@"receiveAd" placeType:self.placeType unitId:ad.adUnitID];

}

- (void)interstitial:(nonnull GADInterstitial *)ad
didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    [[HFAdmobManager shareInstance] eventWithEventName:@"receiveAdFail" placeType:self.placeType unitId:ad.adUnitID];
}

#pragma mark Display-Time Lifecycle Notifications
- (void)interstitialWillPresentScreen:(nonnull GADInterstitial *)ad {
    [[HFAdmobManager shareInstance] eventWithEventName:@"adShow" placeType:self.placeType unitId:ad.adUnitID];

}

/// Called when |ad| fails to present.
- (void)interstitialDidFailToPresentScreen:(nonnull GADInterstitial *)ad {
    
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(nonnull GADInterstitial *)ad {
    [[HFAdmobManager shareInstance] eventWithEventName:@"adHidden" placeType:self.placeType unitId:ad.adUnitID];

}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(nonnull GADInterstitial *)ad {
    
}

- (void)interstitialWillLeaveApplication:(nonnull GADInterstitial *)ad {
//    [VSEventManager logAdsClickWithPlaceType:self.placeType unitId:ad.adUnitID];
    [[HFAdmobManager shareInstance] eventWithEventName:@"adClick" placeType:self.placeType unitId:ad.adUnitID];

    [VSAdShowClickAdsManager addClickAdsWithPlaceType:self.placeType];
}
@end
