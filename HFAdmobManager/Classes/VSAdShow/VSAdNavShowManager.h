//
//  VSAdNavShowManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import <Foundation/Foundation.h>
#import "VSAdNavTemplateHomeBottom.h"
#import "VSAdNavTemplateLayoutDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface VSAdNavShowManager : NSObject

+ (void)showNavAdWithNav:(GADNativeAd *)nativeAd
                  adUnit:(NSString *)adUnit
               placeType:(VSAdShowPlaceType)placeType
              controller:(UIViewController *)controller;

+ (void)showNavAdWithNav:(GADNativeAd *)nativeAd
                  adUnit:(NSString *)adUnit
             containView:(UIView *)containView
                delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate>)delegate;

+ (void)showNavAdWithNav:(GADNativeAd *)nativeAd
                  adUnit:(NSString *)adUnit
             containView:(UIView *)containView
                delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate>)delegate
          layoutDelegate:(id<VSAdNavTemplateLayoutDelegate> _Nullable)layoutDelegate;

+ (BOOL)showNavAdWithNav:(GADNativeAd *)nativeAd
                  adUnit:(NSString *)adUnit
                    cell:(UITableViewCell *)cell;

+ (BOOL)showNavAdWithNav:(GADNativeAd *)nativeAd
                  adUnit:(NSString *)adUnit
                    cell:(UITableViewCell *)cell
          layoutDelegate:(id<VSAdNavTemplateLayoutDelegate> _Nullable)layoutDelegate;

+ (void)closeFullscreenAds;
@end

NS_ASSUME_NONNULL_END
