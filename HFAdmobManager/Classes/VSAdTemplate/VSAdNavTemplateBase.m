//
//  VSAdTemplateBase.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "VSAdNavTemplateBase.h"
#import "VSAdShowClickAdsManager.h"


@interface VSAdNavTemplateBase ()<GADUnifiedNativeAdDelegate, GADVideoControllerDelegate>


@end

@implementation VSAdNavTemplateBase

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.nativeAdView addSubview:self.adLogoLabel];
        NSAssert(self.nativeAdView != nil, @"bala");
    }
    return self;
}

#pragma mark - public
#pragma mark - private
- (void)configWithNativeAd:(GADUnifiedNativeAd *)nativeAd {
    [self layoutTemplateWithNativeAdView:self.nativeAdView];
    
    GADUnifiedNativeAdView *nativeAdView = self.nativeAdView;
    nativeAdView.nativeAd = nativeAd;
    nativeAd.delegate = self;
    
    nativeAdView.mediaView.mediaContent = nativeAd.mediaContent;
    nativeAdView.mediaView.contentMode = UIViewContentModeScaleAspectFill;
    nativeAdView.clipsToBounds = YES;
    nativeAdView.mediaView.clipsToBounds = YES;
    
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
    
    // 安装应用
    [((UIButton *)nativeAdView.callToActionView) setTitle:nativeAd.callToAction
                                                 forState:UIControlStateNormal];
    nativeAdView.callToActionView.hidden = nativeAd.callToAction ? NO : YES;
    nativeAdView.callToActionView.userInteractionEnabled = NO;
    
}

#pragma mark - VSAdNavTemplateLayoutDelegate
- (void)layoutTemplateWithNativeAdView:(GADUnifiedNativeAdView *)nativeAdView {
    
}

#pragma mark - GADUnifiedNativeAdDelegate
- (void)nativeAdDidRecordImpression:(nonnull GADUnifiedNativeAd *)nativeAd {
//    [VSEventManager logAdsClickWithPlaceType:self.placeType unitId:self.adUnitId];

}

- (void)nativeAdDidRecordClick:(nonnull GADUnifiedNativeAd *)nativeAd {
//    [VSEventManager logAdsClickWithPlaceType:self.placeType unitId:self.adUnitId];
    
    
//    [VPNEventManager logEventWithName:kFireEvent_Ads_AdClick param:@{@"adUnitId": self.adUnitId, @"place": self.showAdPlaceId}];
//    [LNToolManager addClickAdsWithAdPlaceId:self.showAdPlaceId];
    
    [VSAdShowClickAdsManager addClickAdsWithPlaceType:self.placeType];
}

- (void)nativeAdWillPresentScreen:(nonnull GADUnifiedNativeAd *)nativeAd {
//    [VSEventManager logAdsShowStartWithPlace:self.placeType];
}

- (void)nativeAdWillDismissScreen:(nonnull GADUnifiedNativeAd *)nativeAd {
//    [VSEventManager logAdsShowEndWithPlace:self.placeType unitId:self.adUnitId];
}

- (void)nativeAdDidDismissScreen:(nonnull GADUnifiedNativeAd *)nativeAd {
    
}

- (void)nativeAdWillLeaveApplication:(nonnull GADUnifiedNativeAd *)nativeAd {
    if (self.placeType == VSAdShowPlaceTypePartHome) {
        // 首页的广告被点击
        if ([self.homeBottomClickdelgate respondsToSelector:@selector(clickAdInHomeBottomAds:)]) {
            [self.homeBottomClickdelgate clickAdInHomeBottomAds:nil];
        }
    }
}

- (void)nativeAdIsMuted:(nonnull GADUnifiedNativeAd *)nativeAd {
    
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

- (GADUnifiedNativeAdView *)nativeAdView {
    if (!_nativeAdView) {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"VSAdNavTemplateView" owner:nil options:nil];
        _nativeAdView = nibObjects.firstObject;
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
