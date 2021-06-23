//
//  VSAdTemplateBase.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "VSAdNavTemplateBase.h"
#import <HFAdmobManager/HFAdmobManager.h>
#import "HFAdsDisplayRatio.h"

@interface VSAdNavTemplateBase ()<GADCustomNativeAdDelegate, GADVideoControllerDelegate, GADNativeAdDelegate>


@end

@implementation VSAdNavTemplateBase

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.nativeAdView addSubview:self.adLogoLabel];
    }
    return self;
}

#pragma mark - public
#pragma mark - private
- (void)configWithNativeAd:(GADNativeAd *)nativeAd {
#ifdef DEBUG
    [HFAdsDisplayRatio addShowWithAdPlace:self.placeType unitType:VSAdUnitTypeNav];
#endif
    
    [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_adShow placeType:self.placeType unitId:self.adUnitId];
    
    GADNativeAdView *nativeAdView = self.nativeAdView;
    nativeAdView.nativeAd = nativeAd;
    nativeAd.delegate = self;
    
    nativeAdView.mediaView.mediaContent = nativeAd.mediaContent;
    nativeAdView.mediaView.contentMode = UIViewContentModeScaleToFill;
    nativeAdView.clipsToBounds = YES;
    nativeAdView.mediaView.clipsToBounds = YES;
    
    nativeAdView.mediaView.backgroundColor = UIColor.clearColor;
    
    nativeAdView.backgroundColor = UIColor.clearColor;
    // 这里需要设置，否者广告无法点击
    nativeAdView.userInteractionEnabled = YES;
    
    
    // title
    ((UILabel *)nativeAdView.headlineView).textAlignment = NSTextAlignmentNatural;
    // 内容
    ((UILabel *)nativeAdView.bodyView).textAlignment = NSTextAlignmentNatural;
    
    if (nativeAd.mediaContent.hasVideoContent) {
        nativeAd.mediaContent.videoController.delegate = self;
        //        DebugLog(@"包含视频")
    } else {
        //        DebugLog(@"不包含视频")
    }
    
    // icon
    ((UIImageView *)nativeAdView.iconView).image = nativeAd.icon.image;
    nativeAdView.iconView.hidden = nativeAd.icon ? NO : YES;
    
    // title
    ((UILabel *)nativeAdView.headlineView).text = nativeAd.headline;
    ((UILabel *)nativeAdView.headlineView).textColor = UIColor.whiteColor;
    nativeAdView.headlineView.hidden = nativeAd.headline ? NO:YES;
    
    // 内容
    ((UILabel *)nativeAdView.bodyView).text = nativeAd.body;
    ((UILabel *)nativeAdView.bodyView).textColor = UIColor.whiteColor;
    nativeAdView.bodyView.hidden = nativeAd.body ? NO : YES;
    nativeAdView.bodyView.hidden = NO;
    
    // 安装应用
    [((UIButton *)nativeAdView.callToActionView) setTitle:nativeAd.callToAction
                                                 forState:UIControlStateNormal];
    nativeAdView.callToActionView.hidden = nativeAd.callToAction ? NO : YES;
    nativeAdView.callToActionView.userInteractionEnabled = NO;
    
    nativeAdView.imageView.hidden = YES;
    nativeAdView.starRatingView.hidden = YES;
    nativeAdView.advertiserView.hidden = YES;
    nativeAdView.adChoicesView.hidden = YES;
    nativeAdView.storeView.hidden = YES;
    nativeAdView.priceView.hidden = YES;
    
    
    nativeAdView.headlineView.userInteractionEnabled = NO;
    nativeAdView.callToActionView.userInteractionEnabled = NO;
    nativeAdView.iconView.userInteractionEnabled = NO;
    nativeAdView.bodyView.userInteractionEnabled = NO;
    nativeAdView.storeView.userInteractionEnabled = NO;
    nativeAdView.priceView.userInteractionEnabled = NO;
    nativeAdView.imageView.userInteractionEnabled = NO;
    nativeAdView.starRatingView.userInteractionEnabled = NO;
    nativeAdView.advertiserView.userInteractionEnabled = NO;
    nativeAdView.mediaView.userInteractionEnabled = NO;
    nativeAdView.adChoicesView.userInteractionEnabled = NO;
    
    // 先处理数据，在根据数据调整布局
    [self layoutTemplateWithNativeAdView:self.nativeAdView];
}

#pragma mark - VSAdNavTemplateLayoutDelegate
- (void)layoutTemplateWithNativeAdView:(GADNativeAdView *)nativeAdView {
    
}

#pragma mark Ad Lifecycle Events
/// Called when an impression is recorded for a custom native ad.
- (void)customNativeAdDidRecordImpression:(nonnull GADCustomNativeAd *)nativeAd; {
    
}

/// Called when a click is recorded for a custom native ad.
- (void)customNativeAdDidRecordClick:(nonnull GADCustomNativeAd *)nativeAd {
    
}

#pragma mark Click-Time Lifecycle Notifications
- (void)customNativeAdWillPresentScreen:(nonnull GADCustomNativeAd *)nativeAd {
}

- (void)customNativeAdWillDismissScreen:(nonnull GADCustomNativeAd *)nativeAd {
    
}

- (void)customNativeAdDidDismissScreen:(nonnull GADCustomNativeAd *)nativeAd {
    if (self.placeType == VSAdShowPlaceTypePartHome) {
        // 首页的广告被点击
        if ([self.homeBottomClickdelgate respondsToSelector:@selector(clickAdInHomeBottomAds:)]) {
            [self.homeBottomClickdelgate clickAdInHomeBottomAds:nil];
        }
    }
}

#pragma mark - GADVideoControllerDelegate
- (void)videoControllerDidPlayVideo:(nonnull GADVideoController *)videoController {
    
}

- (void)videoControllerDidPauseVideo:(nonnull GADVideoController *)videoController {
    
}

- (void)videoControllerDidEndVideoPlayback:(nonnull GADVideoController *)videoController {
    
}

- (void)videoControllerDidMuteVideo:(nonnull GADVideoController *)videoController {
    
}

- (void)videoControllerDidUnmuteVideo:(nonnull GADVideoController *)videoController {
    
}

#pragma mark - lazy
- (UILabel *)adLogoLabel {
    if (!_adLogoLabel) {
        _adLogoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HF_kScaleWidth(30), HF_kScaleWidth(15))];
        _adLogoLabel.text = @"AD";
        _adLogoLabel.textAlignment = NSTextAlignmentCenter;
        _adLogoLabel.textColor = UIColor.whiteColor;
        _adLogoLabel.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.75];
    }
    return _adLogoLabel;
}

- (GADNativeAdView *)nativeAdView {
    if (!_nativeAdView) {
        NSArray *nibs = [MYBUNDLE loadNibNamed:@"VSAdNavTemplateView" owner:nil options:nil];
        _nativeAdView = nibs.firstObject;
    }
    return _nativeAdView;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"--- 释放 --- %@",self);
#endif
}
@end
