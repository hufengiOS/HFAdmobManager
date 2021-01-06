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
- (void)clickAdInHomeBottomAds:(VSAdNavTemplateHomeBottom *)homeBottomAds;
@end


@interface VSAdNavTemplateBase : NSObject {
//    GADUnifiedNativeAdView *_nativeAdView;
}

@property (nonatomic, weak) id<VSAdNavTemplateHomeBottomClickDelegate> homeBottomClickdelgate;

@property (nonatomic, assign) VSAdShowPlaceType placeType;
@property (nonatomic, strong) NSString *adUnitId;
@property (nonatomic, strong) GADUnifiedNativeAdView *nativeAdView;
@property (nonatomic, strong) UILabel *adLogoLabel;

//@property (nonatomic, weak) id<GADUnifiedNativeAdDelegate, GADVideoControllerDelegate> delegate;

- (void)configWithNativeAd:(GADUnifiedNativeAd *)nativeAd;
@end

NS_ASSUME_NONNULL_END
