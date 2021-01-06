//
//  VSAdNavTemplateCell.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateCell.h"
#import "VSTableAdsCell.h"
#import <Masonry/Masonry.h>


@interface VSAdNavTemplateCell ()

@property (nonatomic, weak) UIView *containView;

@end

@implementation VSAdNavTemplateCell

#pragma mark - public
- (BOOL)showAdsInCell:(UITableViewCell *)cell nativeAd:(GADUnifiedNativeAd *)nativeAd {
    __block BOOL failure = NO;
    // 已经展示了广告，就不展示了
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[GADUnifiedNativeAdView class]]) {
            failure = YES;
            *stop = YES;
        }
    }];
    
    if (failure) {
        return YES;
    }
    
    if ([cell isKindOfClass:[VSTableAdsCell class]]) {
        self.containView = ((VSTableAdsCell *)cell).mainView;
    }
    [self.containView addSubview:self.nativeAdView];
    [self configWithNativeAd:nativeAd];
    
    self.placeType = VSAdShowPlaceTypePartOther;

    return YES;
}

+ (CGFloat)heightOfAdCell {
    return 200;
}

#pragma mark - VSAdNavTemplateLayoutDelegate
- (void)layoutTemplateWithNativeAdView:(GADUnifiedNativeAdView *)nativeAdView {
    
    self.nativeAdView.backgroundColor = UIColor.clearColor;
    
    [self.nativeAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.containView.mas_leading);
        make.trailing.equalTo(self.containView.mas_trailing);
        make.top.equalTo(self.containView.mas_top);
        make.bottom.equalTo(self.containView.mas_bottom);
    }];
    
    [self.adLogoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nativeAdView.mas_top);
        make.leading.equalTo(nativeAdView.mas_leading);
        make.size.mas_equalTo(CGSizeMake(HF_kScaleWidth(50), HF_kScaleWidth(20)));
    }];
    
    nativeAdView.mediaView.backgroundColor = UIColor.whiteColor;
    nativeAdView.mediaView.contentMode = UIViewContentModeScaleAspectFill;
    
    [nativeAdView.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(nativeAdView);
        make.width.mas_equalTo(nativeAdView.mediaView.mas_height).multipliedBy(1.91);
    }];
    
    [nativeAdView.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HF_kScaleWidth(50), HF_kScaleWidth(50)));
        make.top.equalTo(nativeAdView.mas_top).offset(HF_kScaleWidth(20));
        make.leading.equalTo(nativeAdView.mas_leading).offset(HF_kScaleWidth(20));
    }];
    
    if (nativeAdView.iconView.hidden) {
        [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(nativeAdView.mas_leading).offset(HF_kScaleWidth(15));
            make.trailing.equalTo(nativeAdView.mas_trailing).offset(HF_kScaleWidth(-15));
            make.top.equalTo(nativeAdView.mas_top).offset(HF_kScaleWidth(20));
            make.height.mas_equalTo(HF_kScaleWidth(40));
        }];
    } else {
        [nativeAdView.headlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(nativeAdView.mas_leading).offset(HF_kScaleWidth(10 + 50 + 10));
            make.trailing.equalTo(nativeAdView.mas_trailing).offset(HF_kScaleWidth(-15));
            make.top.equalTo(nativeAdView.iconView.mas_top).offset(HF_kScaleWidth(0));
            make.height.mas_equalTo(HF_kScaleWidth(40));
        }];
    }
    
    nativeAdView.bodyView.hidden = YES;
    [nativeAdView.callToActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nativeAdView).offset(HF_kScaleWidth(50));
        make.right.equalTo(nativeAdView).offset(HF_kScaleWidth(-50));
        make.height.mas_equalTo(HF_kScaleWidth(50));
//        make.top.equalTo(nativeAdView).offset(HF_kScaleWidth(50 + 20 + 10));
        make.bottom.equalTo(nativeAdView.mas_bottom).offset(HF_kScaleWidth(-10));
    }];
    
    
    nativeAdView.imageView.hidden = YES;
    nativeAdView.starRatingView.hidden = YES;
    nativeAdView.advertiserView.hidden = YES;
    nativeAdView.adChoicesView.hidden = YES;
    nativeAdView.storeView.hidden = YES;
    nativeAdView.priceView.hidden = YES;
}


@end
