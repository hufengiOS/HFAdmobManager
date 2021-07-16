//
//  VSAdBannerShowManager.h
//  HFAdmobManager
//
//  Created by hf on 2021/5/27.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN
@class GADBannerView;
@interface VSAdBannerShowManager : NSObject

+ (BOOL)showAdWithContainView:(UIView *)containView
           rootViewController:(UIViewController *)rootViewController
                    placeType:(VSAdShowPlaceType)placeType
                   bannerView:(GADBannerView *)bannerView;

@property (nonatomic, assign) VSAdShowPlaceType placeType;;

@end

NS_ASSUME_NONNULL_END
