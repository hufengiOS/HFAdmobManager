//
//  VSAdNavShowManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import <Foundation/Foundation.h>
#import "VSAdNavTemplateHomeBottom.h"



NS_ASSUME_NONNULL_BEGIN

@interface VSAdNavShowManager : NSObject

+ (void)showNavAdWithNav:(GADNativeAd *)nativeAd adUnit:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType controller:(UIViewController *)controller;
+ (void)showNavAdWithNav:(GADNativeAd *)nativeAd adUnit:(NSString *)adUnit containView:(UIView *)containView delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate>)delegate;
+ (BOOL)showNavAdWithNav:(GADNativeAd *)nativeAd adUnit:(NSString *)adUnit cell:(UITableViewCell *)cell;

+ (void)closeFullscreenAds;
@end

NS_ASSUME_NONNULL_END
