//
//  VSAdNavTemplateHomeBottom.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateHomeBottom.h"
#import <Masonry/Masonry.h>
#import "Ad_AppConfiger.h"



@interface VSAdNavTemplateHomeBottom ()

@property (nonatomic, weak) UIView *containView;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, weak) id<VSAdNavTemplateHomeBottomDelegate> closeDelegate;

@end


@implementation VSAdNavTemplateHomeBottom

#pragma mark - public
- (void)showInContainView:(UIView *)containView
                 nativeAd:(GADUnifiedNativeAd *)nativeAd
                 delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate> _Nullable)delegate {
    
    if (containView) {
//        [containView removeAllSubViews];
        self.containView = containView;
        containView.clipsToBounds = YES;
        [self.containView addSubview:self.nativeAdView];
        [self.containView addSubview:self.closeBtn];
        [self configWithNativeAd:nativeAd];
        [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn.hidden = YES;
        
        self.placeType = VSAdShowPlaceTypePartHome;
        self.homeBottomClickdelgate = delegate;
        self.closeDelegate = delegate;
    }
}

#pragma mark - action
- (void)closeAction {
    if ([self.closeDelegate respondsToSelector:@selector(closeAdInHomeBottomAds:)]) {
        [self.closeDelegate closeAdInHomeBottomAds:self];
    }
//    [self closeAds];
}

- (void)closeAds {
//    [self.containView removeAllSubViews];
}

#pragma mark - VSAdNavTemplateLayoutDelegate
- (void)layoutTemplateWithNativeAdView:(GADUnifiedNativeAdView *)nativeAdView {

    
    CGFloat topSpace = HF_kFrameValueForDevice(HF_kScaleWidth(20), HF_kScaleWidth(30));
    CGFloat leadingSpace = HF_kFrameValueForDevice(HF_kScaleWidth(15), HF_kScaleWidth(20));
    CGFloat xSpace = HF_kFrameValueForDevice(HF_kScaleWidth(10), HF_kScaleWidth(20));
    CGFloat ySpace = xSpace;
    
    [self.nativeAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.containView);
        make.top.equalTo(self.containView.mas_top);
        make.bottom.equalTo(self.containView.mas_bottom);
    }];
    [self.adLogoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nativeAdView.mas_top);
        make.leading.equalTo(nativeAdView.mas_leading);
        make.size.mas_equalTo(CGSizeMake(HF_kScaleWidth(50), HF_kScaleWidth(20)));
    }];
    
    nativeAdView.mediaView.contentMode = UIViewContentModeScaleToFill;
    
    [nativeAdView.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(nativeAdView);
    }];
    
    [nativeAdView.mediaView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:(UILayoutConstraintAxisVertical)];
    [nativeAdView.mediaView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:(UILayoutConstraintAxisVertical)];
    
    [nativeAdView.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HF_kScaleWidth(50), HF_kScaleWidth(50)));
        make.top.equalTo(nativeAdView.mediaView.mas_bottom).offset(ySpace);
        make.leading.equalTo(nativeAdView.mas_leading).offset(leadingSpace);
    }];
    
    [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!nativeAdView.iconView.hidden) {
            make.leading.equalTo(nativeAdView.iconView.mas_trailing).offset(leadingSpace + xSpace);
        } else {
            make.leading.equalTo(nativeAdView.mas_leading).offset(leadingSpace);
        }
        make.trailing.equalTo(nativeAdView.mas_trailing).offset(- leadingSpace);
        make.top.equalTo(nativeAdView.mediaView.mas_bottom).offset(ySpace);
    }];
    
    [nativeAdView.bodyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!nativeAdView.iconView.hidden) {
            make.top.equalTo(nativeAdView.iconView.mas_bottom).offset(ySpace);
        } else {
            make.top.equalTo(nativeAdView.headlineView.mas_bottom).offset(ySpace);
        }
        make.leading.equalTo(nativeAdView.mas_leading).offset(leadingSpace);
        make.trailing.equalTo(nativeAdView.mas_trailing).offset(- leadingSpace);
        make.bottom.equalTo(nativeAdView.callToActionView.mas_top).offset(-ySpace);
    }];
    
    [nativeAdView.callToActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nativeAdView).offset(leadingSpace);
        make.trailing.equalTo(nativeAdView).offset(-leadingSpace);
        make.height.mas_equalTo(HF_kScaleWidth(50));
        make.bottom.equalTo(nativeAdView.mas_bottom).offset(-topSpace);
    }];
    
}

#pragma mark - lazy
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"i_shutdown"] forState:UIControlStateNormal];
        _closeBtn.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.7];
//        _closeBtn.layer.cornerRadius = HF_kScaleWidth(10);
    }
    return _closeBtn;
}


@end
