//
//  VSAdNavTemplateBase.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"
#import <GoogleMobileAds/GoogleMobileAds.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AdsNavTemplateType) {
    AdsNavTemplateTypeDefault,
    AdsNavTemplateTypeFullScreen
};

@class VSAdNavTemplateHomeBottom;

@protocol VSAdNavTemplateHomeBottomClickDelegate <NSObject>
- (void)clickAdInHomeBottomAds:(VSAdNavTemplateHomeBottom * _Nullable)homeBottomAds;
@end


@interface VSAdNavTemplateBase : NSObject {
//    GADNativeAdView *_nativeAdView;
}

@property (nonatomic, weak) id<VSAdNavTemplateHomeBottomClickDelegate> homeBottomClickdelgate;

@property (nonatomic, assign) VSAdShowPlaceType placeType;
@property (nonatomic, strong) NSString *adUnitId;
@property (nonatomic, strong) GADNativeAdView *nativeAdView;
@property (nonatomic, strong) UILabel *adLogoLabel;

- (void)configWithNativeAd:(GADNativeAd *)nativeAd;
@end

NS_ASSUME_NONNULL_END
