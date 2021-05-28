//
//  VSAdPlaceManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/25.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSAdPlaceManager : NSObject

- (void)loadAdsWithPlaceType:(VSAdShowPlaceType)placeType
           completionHandler:(void (^ _Nullable)(BOOL success))completionHandler;

- (void)loadBannerAdsWithPlaceType:(VSAdShowPlaceType)placeType
                       containView:(UIView * _Nullable)containView
                    rootController:(UIViewController *)rootController
                 completionHandler:(void (^ _Nullable)(BOOL success))completionHandler;
@end

NS_ASSUME_NONNULL_END
