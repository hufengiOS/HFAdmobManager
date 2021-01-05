//
//  VSAdNavTemplateHomeBottom.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateHomeBottom.h"
#import <Masonry/Masonry.h>
#import "HFAppConfiger.h"



@interface VSAdNavTemplateHomeBottom ()

@property (nonatomic, weak) UIView *containView;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, weak) id<VSAdNavTemplateHomeBottomDelegate> closeDelegate;

@end


@implementation VSAdNavTemplateHomeBottom

#pragma mark - public
- (void)showInContainView:(UIView *)containView nativeAd:(GADUnifiedNativeAd *)nativeAd delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate>)delegate {
    if (containView) {
        
//        [containView removeAllSubViews];
        self.containView = containView;
        containView.clipsToBounds = YES;
        [self.containView addSubview:self.nativeAdView];
        [self.containView addSubview:self.closeBtn];
        [self configWithNativeAd:nativeAd];
        [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
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
    
    nativeAdView.mediaView.backgroundColor = UIColor.clearColor;
    nativeAdView.mediaView.contentMode = UIViewContentModeScaleAspectFill;
    
    // title
    ((UILabel *)nativeAdView.headlineView).textAlignment = NSTextAlignmentNatural;
    // 内容
    ((UILabel *)nativeAdView.bodyView).textAlignment = NSTextAlignmentNatural;
    
    
    nativeAdView.bodyView.hidden = YES;
    nativeAdView.imageView.hidden = YES;
    nativeAdView.starRatingView.hidden = YES;
    nativeAdView.advertiserView.hidden = YES;
    nativeAdView.adChoicesView.hidden = YES;
    nativeAdView.storeView.hidden = YES;
    nativeAdView.priceView.hidden = YES;
    
    
    self.nativeAdView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    [self.nativeAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.trailing.equalTo(self.containView);
        make.top.equalTo(self.containView.mas_top);
        make.bottom.equalTo(self.containView.mas_bottom);
    }];
    
    [self.adLogoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nativeAdView.mas_top);
        make.leading.equalTo(nativeAdView.mas_leading);
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(50), kScaleWidth(20)));
    }];

    if (isIPad) {
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScaleWidth(20), kScaleWidth(20)));
            make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-0));
            make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(0));
        }];
        
        [nativeAdView.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(nativeAdView);
            make.width.mas_equalTo(nativeAdView.mediaView.mas_height).multipliedBy(1.91);
        }];
        
        [nativeAdView.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScaleWidth(50), kScaleWidth(50)));
            make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(20));
            make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(20));
        }];
        
        
        if (nativeAdView.iconView.hidden) {
            [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(15));
                make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-15));
                make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(20));
                make.height.mas_equalTo(kScaleWidth(40));
            }];
            
        } else {
            [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(10 + 50 + 10));
                make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-15));
                make.top.equalTo(nativeAdView.iconView.mas_top).offset(kScaleWidth(0));
                make.height.mas_equalTo(kScaleWidth(40));
            }];
            
        }
        [nativeAdView.callToActionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nativeAdView).offset(kScaleWidth(50));
            make.right.equalTo(nativeAdView).offset(kScaleWidth(-50));
            make.height.mas_equalTo(kScaleWidth(50));
            make.bottom.equalTo(nativeAdView.mas_bottom).offset(kScaleWidth(-20) - kHomeBarHeight);
        }];
        
        [nativeAdView.bodyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(nativeAdView.headlineView.mas_leading);
            make.trailing.equalTo(nativeAdView.headlineView.mas_trailing);
            make.top.equalTo(nativeAdView.headlineView.mas_bottom).offset(kScaleWidth(10));
            make.bottom.mas_greaterThanOrEqualTo(nativeAdView.callToActionView.mas_top).offset(kScaleWidth(-10));
        }];
        
    } else {
        if (isFullScreenDevice) {
            [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScaleWidth(20), kScaleWidth(20)));
                make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-0));
                make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(0));
            }];
            
            [nativeAdView.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(nativeAdView);
                make.width.mas_equalTo(nativeAdView.mediaView.mas_height).multipliedBy(1.91);
            }];
            
            [nativeAdView.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScaleWidth(50), kScaleWidth(50)));
                make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(20));
                make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(20));
            }];
            
            if (nativeAdView.iconView.hidden) {
                [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(15));
                    make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-15));
                    make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(20));
                    make.height.mas_equalTo(kScaleWidth(40));
                }];
            } else {
                [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(10 + 50 + 10));
                    make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-15));
                    make.top.equalTo(nativeAdView.iconView.mas_top).offset(kScaleWidth(0));
                    make.height.mas_equalTo(kScaleWidth(40));
                }];
            }
            
            [nativeAdView.callToActionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(nativeAdView).offset(kScaleWidth(50));
                make.right.equalTo(nativeAdView).offset(kScaleWidth(-50));
                make.height.mas_equalTo(kScaleWidth(50));
//                make.top.equalTo(nativeAdView).offset(kScaleWidth(50 + 20 + 10));
                make.bottom.equalTo(nativeAdView.mas_bottom).offset(- kHomeBarHeight - kScaleWidth(10));
            }];
        } else {
            [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScaleWidth(20), kScaleWidth(20)));
                make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-0));
                make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(0));
            }];
            
            [nativeAdView.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(nativeAdView);
                make.width.mas_equalTo(nativeAdView.mediaView.mas_height).multipliedBy(1.91);
            }];
            
            [nativeAdView.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScaleWidth(50), kScaleWidth(50)));
                //            make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(20));
                make.centerY.equalTo(nativeAdView.mas_centerY);
                make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(20));
            }];
            
            if (nativeAdView.iconView.hidden) {
                [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(15));
                    make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-15));
                    //                make.top.equalTo(nativeAdView.mas_top).offset(kScaleWidth(20));
                    make.centerY.equalTo(nativeAdView.mas_centerY);
                    make.height.mas_equalTo(kScaleWidth(40));
                }];
            } else {
                [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(nativeAdView.mas_leading).offset(kScaleWidth(10 + 50 + 10));
                    make.trailing.equalTo(nativeAdView.mas_trailing).offset(kScaleWidth(-15));
                    //                make.top.equalTo(nativeAdView.iconView.mas_top).offset(kScaleWidth(0));
                    make.centerY.equalTo(nativeAdView.mas_centerY);
                    make.height.mas_equalTo(kScaleWidth(40));
                }];
            }
            
            nativeAdView.callToActionView.hidden = YES;
        }
        
    }
    
    
    
}

#pragma mark - lazy
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"i_shutdown"] forState:UIControlStateNormal];
        _closeBtn.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.7];
//        _closeBtn.layer.cornerRadius = kScaleWidth(10);
    }
    return _closeBtn;
}


@end
