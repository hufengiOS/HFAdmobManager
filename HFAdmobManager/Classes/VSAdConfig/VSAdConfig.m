//
//  VSAdConfig.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "VSAdConfig.h"
//#import "HFPayListLoader.h"
#import "VSGlobalConfigManager.h"
#import "VSAdUnit.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "VSAdMacro.h"
#import "VSAdShowClickAdsManager.h"


static NSString *const kFinishAuthoreConnectKey = @"kFinishAuthoreConnectKey";

@implementation VSAdConfig


+ (void)configAds {
    [[GADMobileAds sharedInstance] startWithCompletionHandler:^(GADInitializationStatus * _Nonnull status) {
//        NSDictionary *adapterStatuses = [status adapterStatusesByClassName];
//        for (NSString *adapter in adapterStatuses) {
////            GADAdapterStatus *adapterStatus = adapterStatuses[adapter];
////            NSLog(@"Adapter Name: %@, Description: %@, Latency: %f", adapter,
////                    adapterStatus.description, adapterStatus.latency);
//        }
        
    }];
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = [self testDeviceIdentifiers];
    [GADMobileAds sharedInstance].applicationVolume = 0.2;
}

+ (NSArray *)testDeviceIdentifiers {
    return @[        
        @"5ea6ccde6ffa92dee9f51c3d2cc259b9",// 测试机 6
        @"23ba95524019f147cbd29761b55fd036", // Snake iPhone 8
        @"", // 王峰 iPhone 8
        @"c3c7dbb0800fff474b2f6a61b025b2d5", // 测试机 iPhone 8P
        @"729bb2d6e735f8ca7e3c51f6030129a4", // 小丽 iPhone 7
        @"7bfe45c23f3ef5b4eb1f8b4d9be2504b", // 小丽 iPhone 12
        @"159311b664bc129ed22f968861065c4c", // 测试机 iPad Air
        @"4acaaf36dbfec66fda7a226d22855bfe"  // 测试机 XR
    ];
}

+ (BOOL)allowRequestWithShowPlaceType:(VSAdShowPlaceType)placeType {
//    if ([HFPayListLoader shareInstance].isVip) {
//        return NO;
//    }
    if (![VSAdShowClickAdsManager allowClickWithPlaceType:placeType]) {
        return NO;
    }
    for (VSGlobalConfigAdsConfigModel *model in [VSGlobalConfigManager shareInstance].configModel.adCfgs) {
        if (model.adNameType == placeType) {
            return model.isReq && (model.adNameType == placeType);
        }
    }
    return NO;
}

+ (BOOL)allowShowWithShowPlaceType:(VSAdShowPlaceType)placeType {
//    if ([HFPayListLoader shareInstance].isVip) {
//        return NO;
//    }
    
    if (![VSAdShowClickAdsManager allowClickWithPlaceType:placeType]) {
        return NO;
    }
    if (placeType == VSAdShowPlaceTypeFullStart || placeType == VSAdShowPlaceTypePartHome) {
        if (![VSAdConfig allowShowFromVpnAuthorLimit]) {
            return NO;
        }
    }
    
    for (VSGlobalConfigAdsConfigModel *model in [VSGlobalConfigManager shareInstance].configModel.adCfgs) {
        if (model.adNameType == placeType) {
            return model.isShow && (model.adNameType == placeType);
        }
    }
    return NO;
}

+ (VSGlobalConfigCloseBtnModel *)closeBtnModelWithPlaceType:(VSAdShowPlaceType)placeType {
    for (VSGlobalConfigAdsConfigModel *model in [VSGlobalConfigManager shareInstance].configModel.adCfgs) {
        if (model.adNameType == placeType) {
            return model.navCloseBtn;
        }
    }
    return nil;
}

+ (BOOL)allowShowFromVpnAuthorLimit {
    return [VSAdConfig openAdBeforeConnect] || [VSAdConfig getConnectAuthorStatus];
}

+ (BOOL)openAdBeforeConnect {
    return [VSGlobalConfigManager shareInstance].configModel.vgfConnOpAd;
}

+ (void)finishConnectAuthor {
    [VSAdUnit saveWithInt:1 key:kFinishAuthoreConnectKey];
}

+ (BOOL)getConnectAuthorStatus {
    return 1 == [VSAdUnit intValueForKey:kFinishAuthoreConnectKey];
}

+ (NSString *)nameWithPlaceType:(VSAdShowPlaceType)placeType {
    NSString *placeTypeStr;
    switch (placeType) {
        case VSAdShowPlaceTypeUnknown:
            placeTypeStr = @"VSAdShowPlaceTypeUnknown";
            break;
        case VSAdShowPlaceTypePartHome:
            placeTypeStr = @"VSAdShowPlaceTypePartHome";
            break;
        case VSAdShowPlaceTypePartOther:
            placeTypeStr = @"VSAdShowPlaceTypePartOther";
            break;
        case VSAdShowPlaceTypeFullStart:
            placeTypeStr = @"VSAdShowPlaceTypeFullStart";
            break;
        case VSAdShowPlaceTypeFullConnect:
            placeTypeStr = @"VSAdShowPlaceTypeFullConnect";
            break;
        case VSAdShowPlaceTypeFullExtra:
            placeTypeStr = @"VSAdShowPlaceTypeFullExtra";
            break;
        default:
            break;
    }
    return placeTypeStr;
}

+ (NSString *)nameWithUnitType:(VSAdUnitType)unitType {
    NSString *unitTypeStr;
    switch (unitType) {
        case VSAdUnitTypeInt:
            unitTypeStr = @"int";
            break;
        case VSAdUnitTypeNav:
            unitTypeStr = @"nav";
            break;
        case VSAdUnitTypeUnknown:
            unitTypeStr = @"unknown";
            break;
        default:
            break;
    }
    return unitTypeStr;
}

@end
