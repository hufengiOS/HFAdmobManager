//
//  VSAdIntShowManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface VSAdIntShowManager : NSObject

+ (BOOL)showIntAdWithController:(UIViewController *)viewController placeType:(VSAdShowPlaceType)placeType interstitial:(GADInterstitial *)interstitial;
+ (void)closeFullscreenAds;
@end

NS_ASSUME_NONNULL_END
