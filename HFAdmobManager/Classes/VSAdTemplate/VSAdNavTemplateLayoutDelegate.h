//
//  VSAdNavTemplateLayoutDelegate.h
//  HFAdmobManager
//
//  Created by hf on 2021/6/23.
//

#import <Foundation/Foundation.h>


@import GoogleMobileAds;

NS_ASSUME_NONNULL_BEGIN

@class GADNativeAdView;
@protocol VSAdNavTemplateLayoutDelegate <NSObject>
- (void)layoutTemplateWithNativeAdView:(GADNativeAdView *)nativeAdView;
@end

NS_ASSUME_NONNULL_END
