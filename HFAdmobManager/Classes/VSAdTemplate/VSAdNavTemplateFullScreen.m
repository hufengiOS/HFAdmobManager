//
//  VSAdNavTemplateFullScreen.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateFullScreen.h"
#import "VSGlobalConfigModel.h"
#import "VSAdUnit.h"
#import "VSAdMacro.h"
#import "VSAdConfig.h"
//#import "UIView+ad_Extension.h"
#import "Ad_AppConfiger.h"
#import <Masonry/Masonry.h>
#import <HFAdmobManager/HFAdmobManager.h>


#define UIColorHexFromRGB(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:1.0]

#define UIColorHexFromRGBA(value,a) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:a]

#define kColor1                UIColorHexFromRGB(0xf86161)
#define kColor2                UIColorHexFromRGB(0xf75779)
#define kColor3                UIColorHexFromRGB(0xe0559a)
#define kColor4                UIColorHexFromRGB(0xb86dd2)
#define kColor5                UIColorHexFromRGB(0x8774d7)
#define kColor6                UIColorHexFromRGB(0x5ba0d9)
#define kColor7                UIColorHexFromRGB(0x2dd9e3)
#define kColor8                UIColorHexFromRGB(0x60b79e)
#define kColor9                UIColorHexFromRGB(0x5cbb7e)
#define kColor10               UIColorHexFromRGB(0x95b976)
#define kColor11               UIColorHexFromRGB(0xffb61b)
#define kColor12               UIColorHexFromRGB(0xffa800)
#define kColor13               UIColorHexFromRGB(0xff7700)

@interface VSAdNavTemplateFullScreen ()

@property (nonatomic, strong) VSFullScreenAdsController *mainController;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) NSArray *fullScreenBackgroundColorArray;

@property (nonatomic, strong) UIImageView *backgroundImageView;



@end

@implementation VSAdNavTemplateFullScreen

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mainController = [[VSFullScreenAdsController alloc] init];
        self.mainController.modalPresentationStyle = UIModalPresentationFullScreen;
        self.mainController.view.backgroundColor = UIColor.whiteColor;
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HF_MainScreen_Width, HF_MainScreen_Height)];
        [self.mainController.view addSubview:self.backgroundImageView];
        
        [self.mainController.view addSubview:self.nativeAdView];
        [self.mainController.view addSubview:self.closeBtn];
        [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

#pragma mark - public
- (void)showInController:(UIViewController *)controller
                nativeAd:(GADNativeAd *)nativeAd {
    
    if (!self.mainController.presentingViewController && ![controller.presentedViewController isKindOfClass:NSClassFromString(@"GADFullScreenAdViewController")]) {
        [self configCloseBtnWithPlaceType:self.placeType];
        // 如果控制器已经被展示，则不弹出
        [self configWithNativeAd:nativeAd];
        self.backgroundImageView.image = [VSAdUnit createImageFromColors:[self fullScreenBackgroundColorArray] withFrame:CGSizeMake(HF_MainScreen_Width, HF_MainScreen_Height)];
        [controller presentViewController:self.mainController animated:self.placeType != VSAdShowPlaceTypeFullStart completion:nil];
    } else {
        
    }
}

- (UIImage *)imageNamed:(NSString *)name {
    return [UIImage imageNamed:name inBundle:MYBUNDLE compatibleWithTraitCollection:nil];
}

#pragma mark - private
- (void)configCloseBtnWithPlaceType:(VSAdShowPlaceType)placeType {
    VSGlobalConfigCloseBtnModel *model = [VSAdConfig closeBtnModelWithPlaceType:placeType];
    if (model.isIcon) {
        
        [self.closeBtn setImage:[self imageNamed:@"close_ads"] forState:UIControlStateNormal];
        [self.closeBtn setTitle:nil forState:UIControlStateNormal];
        
        self.closeBtn.frame = CGRectMake(HF_kScaleWidth(0), HF_kStatusBarHeight, self.closeBtn.frame.size.width, self.closeBtn.frame.size.height);
        self.closeBtn.backgroundColor = UIColor.clearColor;
        
        CGSize size;
        if ([model.iconType.lowercaseString isEqualToString:@"small"]) {
            size = CGSizeMake(HF_kScaleWidth(22), HF_kScaleWidth(22));
        } else if ([model.iconType.lowercaseString isEqualToString:@"big"]) {
            size = CGSizeMake(HF_kScaleWidth(27), HF_kScaleWidth(27));
        } else {
            size = CGSizeMake(HF_kScaleWidth(25), HF_kScaleWidth(25));
        }
        self.closeBtn.frame = CGRectMake(self.closeBtn.frame.origin.x, self.closeBtn.frame.origin.y, size.width, size.height);
    } else {
        [self.closeBtn setImage:nil forState:UIControlStateNormal];
        [self.closeBtn setTitle:@"skip ads" forState:UIControlStateNormal];
        
        CGFloat edgeSpace = 5;
        if ((model.textEdgeSpace >= 1 && model.textEdgeSpace <= 7)) {
            edgeSpace = model.textEdgeSpace;
        }
        self.closeBtn.frame = CGRectMake(0, HF_kStatusBarHeight, HF_kScaleWidth(60), HF_kScaleWidth(15) + edgeSpace*2);
        
        CGFloat textWidth = [self textWidthWithFontSize:self.closeBtn.titleLabel.font height:self.closeBtn.frame.size.height text:self.closeBtn.titleLabel.text];
                
        self.closeBtn.frame = CGRectMake(self.closeBtn.frame.origin.x, self.closeBtn.frame.origin.y, textWidth + edgeSpace * 2, self.closeBtn.frame.size.height);
        
        self.closeBtn.layer.cornerRadius = HF_kScaleWidth(3);
        
    }
}

- (CGFloat)textWidthWithFontSize:(UIFont *)font height:(CGFloat)height text:(NSString *)text {
    
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
}

- (NSArray *)fullScreenBackgroundColorArray {
    NSArray *colors = @[@[UIColorHexFromRGB(0x0f2846), UIColorHexFromRGB(0x558cf0)],
                        @[UIColorHexFromRGB(0x60b79e), UIColorHexFromRGB(0x2dd9e3)],
                        @[UIColorHexFromRGB(0x239d48), UIColorHexFromRGB(0x83bb5b)],
                        @[UIColorHexFromRGB(0x5cbb7e), UIColorHexFromRGB(0x95b976)],
                        @[kColor13, kColor1],
                        @[kColor3, kColor4],
                        @[kColor1, kColor2],
                        @[kColor11, kColor12]];
    
    NSUInteger index = arc4random() % colors.count;
    _fullScreenBackgroundColorArray = colors[index];
    return _fullScreenBackgroundColorArray;
}

- (void)closeFullscreenAds {
    [self closeAction];
}

#pragma mark - action
- (void)closeAction {
    [self.mainController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - VSAdNavTemplateLayoutDelegate
- (void)layoutTemplateWithNativeAdView:(GADNativeAdView *)nativeAdView {
    
    // title
    ((UILabel *)nativeAdView.headlineView).textAlignment = NSTextAlignmentCenter;
    // 内容
    ((UILabel *)nativeAdView.bodyView).textAlignment = NSTextAlignmentCenter;
    
    [self.nativeAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.trailing.equalTo(self.mainController.view);
        make.top.equalTo(self.mainController.view.mas_top).offset(HF_kStatusBarHeight);
        make.bottom.equalTo(self.mainController.view.mas_bottom).offset(-HF_kHomeBarHeight);
    }];
    
    [self.adLogoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nativeAdView.mediaView.mas_bottom);
        make.leading.equalTo(nativeAdView.mediaView.mas_leading);
        make.size.mas_equalTo(CGSizeMake(HF_kScaleWidth(50), HF_kScaleWidth(20)));
    }];
    
    nativeAdView.mediaView.backgroundColor = UIColor.clearColor;
    nativeAdView.mediaView.contentMode = UIViewContentModeScaleAspectFit;
    
    [nativeAdView.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(nativeAdView);
        make.width.mas_equalTo(nativeAdView.mediaView.mas_height).multipliedBy(1.91);
    }];
    
    nativeAdView.iconView.backgroundColor = UIColor.whiteColor;
    
    [nativeAdView.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nativeAdView);
        make.size.mas_equalTo(CGSizeMake(HF_kScaleWidth(50), HF_kScaleWidth(50)));
        make.centerY.equalTo(nativeAdView.mediaView.mas_bottom).offset(HF_kScaleWidth(50));
    }];
    
    [nativeAdView.headlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nativeAdView).offset(HF_kScaleWidth(50));
        make.right.equalTo(nativeAdView).offset(HF_kScaleWidth(-50));
        make.top.equalTo(nativeAdView.iconView.mas_bottom).offset(HF_kScaleWidth(50));
        make.height.mas_equalTo(HF_kScaleWidth(50));
    }];
    
    [nativeAdView.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nativeAdView).offset(HF_kScaleWidth(50));
        make.right.equalTo(nativeAdView).offset(HF_kScaleWidth(-50));
        make.top.equalTo(nativeAdView.headlineView.mas_bottom).offset(HF_kScaleWidth(20));
        make.height.mas_equalTo(HF_kScaleWidth(80));
    }];
    
    [nativeAdView.callToActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nativeAdView).offset(HF_kScaleWidth(50));
        make.right.equalTo(nativeAdView).offset(HF_kScaleWidth(-50));
        make.height.mas_equalTo(HF_kScaleWidth(50));
        make.bottom.equalTo(nativeAdView.mas_bottom).offset(HF_kScaleWidth(-40));
    }];
    
}

#pragma mark - lazy
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, HF_kStatusBarHeight, HF_kScaleWidth(80), HF_kScaleWidth(20))];
        [_closeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _closeBtn.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.75];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:HF_kScreenWidthRatio*13];
        
        
    }
    return _closeBtn;
}

@end

@implementation VSFullScreenAdsController



@end
