//
//  HFViewController.m
//  HFAdmobManager
//
//  Created by hufengiOS on 12/31/2020.
//  Copyright (c) 2020 hufengiOS. All rights reserved.
//

#import "HFViewController.h"
#import <HFAdmobManager/HFAdmobManagerHeader.h>
#import "SCRequest.h"
#import "VSSerializationData.h"


@interface HFViewController ()<HFAdmobManagerEventDelegate, VSAdNavTemplateLayoutDelegate>

@property (nonatomic, strong) UIButton *showAdsBtn;

@property (nonatomic, strong) UIView *adContentView;

@end

@implementation HFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    VSGlobalConfigManager.shareInstance.keyAndValueHandler = ^VSAdShowPlaceType(NSString * _Nonnull adName) {
//        if ([@"AD_REPORT" isEqualToString:adName.uppercaseString]) {
//            return VSAdShowPlaceTypePartOther;
//        }
//        return VSAdShowPlaceTypeUnknown;
//    };
    
    [HFAdmobManager shareInstance].closeAdsHandler = ^BOOL{
        return NO;
    };
    
    VSGlobalConfigManager.shareInstance.defaultConfigHandler = ^NSDictionary * _Nullable{
        // 项目本地广告的默认配置 kGlobalConfigFileName
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"kGlobalConfigFileName" ofType:@"txt"];
        NSString *configStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSDictionary *localDic = [VSSerializationData objectWithJsonString:configStr];
        return localDic;
    };
    
    [[HFAdmobManager shareInstance] openDebugModeWithHandler:^BOOL{
        return YES;
    }];
    [HFAdmobManager shareInstance].delegate = self;
    
    [HFAdmobManager preloadAllAds];
    
    [self requestConfigInfo];
    
    [self.view addSubview:self.showAdsBtn];
    [self.view addSubview:self.adContentView];
    
    self.adContentView.frame = CGRectMake(0, HF_MainScreen_Height - HF_kScaleWidth(500) - 80, HF_MainScreen_Width, HF_kScaleWidth(250));
    self.adContentView.frame = CGRectMake(0, HF_MainScreen_Height - HF_kScaleWidth(500), HF_MainScreen_Width, HF_kScaleWidth(250));
    
    [self.showAdsBtn addTarget:self action:@selector(showAdAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeAdsLoadSuccess:) name:kNotificationNamePartAdLoadSuccussKey object:nil];
    
    
    // 加载banner 广告
//    [HFAdmobManager reloadBannerAdsWithPlaceType:VSAdShowPlaceTypeBanner
//                               completionHandler:nil];
    
    [HFAdmobManager reloadAdsWithPlaceType:(VSAdShowPlaceTypePartOther) notify:YES];
    
//    [HFAdmobManager reloadAdsWithPlaceType:(VSAdShowPlaceTypePartHome) notify:YES completionHandler:^(BOOL success) {
//
//    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)showAdAction {
    
//    [HFAdmobManager showBannerWithPlaceType:(VSAdShowPlaceTypeBanner) containView:self.adContentView controller:self];
    
    [HFAdmobManager showAdsWithPlaceType:VSAdShowPlaceTypeFullExtra controller:self];
    
//    [HFAdmobManager showAdsWithPlaceType:(VSAdShowPlaceTypePartHome) containView:self.adContentView delegate:nil layoutDelegate:self];
}

- (void)requestConfigInfo {
    [SCRequest requestGlobalConfigWithCallBackHandler:^(NSDictionary * _Nullable dataModel, NSError * _Nullable error) {
        if ([dataModel isKindOfClass:[NSDictionary class]] && [dataModel.allKeys containsObject:@"data"]) {
            
            [[VSGlobalConfigManager shareInstance] configWithDic:dataModel[@"data"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameVSGlobalConfigManagerLoadSuccess object:nil];
        } else {
           [[VSGlobalConfigManager shareInstance] configModel];
        }
        
        [HFAdmobManager preloadAllAds];
    }];
}

- (void)homeAdsLoadSuccess:(NSNotification *)notification {
    if (self.adContentView.subviews.count == 0) {
        
//        [HFAdmobManager showAdsWithPlaceType:VSAdShowPlaceTypePartHome containView:self.adContentView delegate:nil];
    }
}

#pragma mark - VSAdNavTemplateLayoutDelegate
- (void)layoutTemplateWithNativeAdView:(GADNativeAdView *)nativeAdView {
    
    
}

#pragma mark - HFAdmobManagerEventDelegate
- (void)admobManagerEventName:(NSString *)eventName placeType:(VSAdShowPlaceType)placeType unitId:(NSString *)unitId {
    HFAd_DebugLog(@" %@ %@ %@", eventName, ADPlaceTypeString(placeType), unitId)
}
     
#pragma mark - lazy
- (UIButton *)showAdsBtn {
    if (!_showAdsBtn) {
        _showAdsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showAdsBtn setTitle:@"展示广告" forState:UIControlStateNormal];
        _showAdsBtn.backgroundColor = UIColor.grayColor;
        _showAdsBtn.frame = CGRectMake(100, 100, 80, 40);
    }
    return _showAdsBtn;
}

- (UIView *)adContentView {
    if (!_adContentView) {
        _adContentView = [[UIView alloc] init];
        _adContentView.backgroundColor = UIColor.blackColor;
    }
    return _adContentView;
}
@end

