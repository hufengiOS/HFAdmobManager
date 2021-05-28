//
//  HFAdmobManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "HFAdmobManager.h"
#import "VSAdPlaceManager.h"
#import "VSAdCacheManager.h"
#import "VSAdIntShowManager.h"
#import "VSAdNavShowManager.h"
#import "VSAdConfig.h"


@interface HFAdmobManager() {
     
}

@property (nonatomic, strong) VSAdPlaceManager *startPlaceManager;
@property (nonatomic, strong) VSAdPlaceManager *connectPlaceManager;
@property (nonatomic, strong) VSAdPlaceManager *extraPlaceManager;
@property (nonatomic, strong) VSAdPlaceManager *homePlaceManager;
@property (nonatomic, strong) VSAdPlaceManager *cellPlaceManager;
@property (nonatomic, strong) VSAdPlaceManager *bannerPlaceManager;

@property (nonatomic, copy) OpenDebugModeHandler openDebugModeHandler;

@end

@implementation HFAdmobManager

+ (instancetype)shareInstance {
    static HFAdmobManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HFAdmobManager alloc] init];
    });
    return manager;
}

- (void)openDebugModeWithHandler:(OpenDebugModeHandler)handler {
    _openDebugModeHandler = handler;
}

- (BOOL)isDEBUGMode {
#ifdef DEBUG
    return !_openDebugModeHandler ? NO : self.openDebugModeHandler();
#else
    return NO;
#endif
}

+ (void)preloadAllAdsWithNotify:(BOOL)notify {
    [self reloadAdsWithPlaceType:VSAdShowPlaceTypeFullStart notify:notify];
    [self reloadAdsWithPlaceType:VSAdShowPlaceTypeFullConnect notify:notify];
    [self reloadAdsWithPlaceType:VSAdShowPlaceTypeFullExtra notify:notify];
    [self reloadAdsWithPlaceType:VSAdShowPlaceTypePartOther notify:notify];
    [self reloadAdsWithPlaceType:VSAdShowPlaceTypePartHome notify:notify];
    
    /**
      banner 广告的加载需要获取到对应控制器，这里不做提前加载
     */
}

+ (void)preloadAllAds {
    [self preloadAllAdsWithNotify:YES];
}

+ (void)reloadAdsWithPlaceType:(VSAdShowPlaceType)placeType notify:(BOOL)notify {
    [self reloadAdsWithPlaceType:placeType notify:notify completionHandler:nil];
}

+ (void)reloadBannerAdsWithPlaceType:(VSAdShowPlaceType)placeType
                         containView:(UIView * _Nullable)containView
                      rootController:(UIViewController *)rootController
                   completionHandler:(void (^ _Nullable)(BOOL success)) completionHandler {
    HFAdmobManager *manager = [HFAdmobManager shareInstance];
    VSAdPlaceManager *placeManager = manager.bannerPlaceManager;
    [placeManager loadBannerAdsWithPlaceType:placeType
                                 containView:containView
                              rootController:rootController
                           completionHandler:^(BOOL success) {
        !completionHandler ? : completionHandler(success);
    }];
}

+ (void)reloadAdsWithPlaceType:(VSAdShowPlaceType)placeType
                        notify:(BOOL)notify
             completionHandler:(void (^ _Nullable)(BOOL success)) completionHandler {
    
    HFAdmobManager *manager = [HFAdmobManager shareInstance];
    VSAdPlaceManager *placeManager;
    if (placeType == VSAdShowPlaceTypePartHome) {
        placeManager = manager.homePlaceManager;
    } else if (placeType == VSAdShowPlaceTypePartOther) {
        placeManager = manager.cellPlaceManager;
    } else if (placeType == VSAdShowPlaceTypeFullStart) {
        placeManager = manager.startPlaceManager;
    } else if (placeType == VSAdShowPlaceTypeFullConnect) {
        placeManager = manager.connectPlaceManager;
    } else if (placeType == VSAdShowPlaceTypeFullExtra) {
        placeManager = manager.extraPlaceManager;
    } else {
        NSAssert(YES, @"没有适配的广告位类型");
    }
    [placeManager loadAdsWithPlaceType:placeType completionHandler:^(BOOL success) {
        !completionHandler ? : completionHandler(success);
        if (notify) {
            if (placeType == VSAdShowPlaceTypePartHome || placeType == VSAdShowPlaceTypePartOther) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNamePartAdLoadSuccussKey object:@(placeType)];
            } else if (placeType == VSAdShowPlaceTypeFullStart || placeType == VSAdShowPlaceTypeFullConnect || placeType == VSAdShowPlaceTypeFullExtra) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameFullScreenAdLoadSuccussKey object:@(placeType)];
            }            
        }
    }];
}

+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType controller:(UIViewController *)controller {
    
    NSAssert(placeType != VSAdShowPlaceTypeBanner && placeType != VSAdShowPlaceTypePartHome && placeType != VSAdShowPlaceTypePartOther, @"广告位类型不支持");
    
    return [self showAdsWithPlaceType:placeType controller:controller cell:nil containView:nil containViewDelegate:nil];
}

+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType containView:(UIView *)containView delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate> _Nullable)delegate {
    return [self showAdsWithPlaceType:placeType controller:nil cell:nil containView:containView containViewDelegate:delegate];
}

+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType cell:(UITableViewCell *)cell {
    return [self showAdsWithPlaceType:placeType controller:nil cell:cell containView:nil containViewDelegate:nil];
}

+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType
                  controller:(UIViewController * _Nullable)controller
                        cell:(UITableViewCell * _Nullable)cell
                 containView:(UIView * _Nullable)containView
         containViewDelegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate> _Nullable)delegate {
    
    if (![VSAdConfig allowShowWithShowPlaceType:placeType]) {
        return NO;
    }
    
    VSAdCacheData *data = [VSAdCacheManager adsWithPlaceType:placeType];
    BOOL showSuccess = YES;
    if (VSAdUnitTypeInt == data.unitType) {
        [VSAdIntShowManager showIntAdWithController:controller placeType:placeType interstitial:(GADInterstitialAd *)data.obj];
    } else if (VSAdUnitTypeNav == data.unitType) {
        if (VSAdShowPlaceTypePartHome == data.placeType || VSAdShowPlaceTypePartOther == data.placeType) {
            if (VSAdShowPlaceTypePartOther == placeType) {
                showSuccess = [VSAdNavShowManager showNavAdWithNav:data.obj adUnit:data.adUnitId cell:cell];
            } else {
                [VSAdNavShowManager showNavAdWithNav:data.obj adUnit:data.adUnitId containView:containView delegate:delegate];
            }
        } else {
            [VSAdNavShowManager showNavAdWithNav:data.obj adUnit:data.adUnitId placeType:placeType controller:controller];
        }
    } else {
        NSAssert(VSAdUnitTypeBanner == data.unitType, @"不支持banner广告");
        HFAd_DebugLog(@"没有广告")
        // 重新拉取广告
        
        [self reloadAdsWithPlaceType:placeType notify:YES];
        return NO;
    }
    if (showSuccess) {
        [VSAdCacheManager removeAdsWithData:data];
        // 缓存数据
        [self reloadAdsWithPlaceType:placeType notify:NO];
    }
    return showSuccess;
}

+ (BOOL)isReadyWithPlaceType:(VSAdShowPlaceType)placeType {
    if (placeType == VSAdShowPlaceTypePartOther || placeType == VSAdShowPlaceTypePartHome) {
        return [VSAdCacheManager adsWithPlaceType:VSAdShowPlaceTypePartOther] != nil || [VSAdCacheManager adsWithPlaceType:VSAdShowPlaceTypePartHome];
    }
    return NO;
}

+ (void)closeFullScrenAds {
    [VSAdNavShowManager closeFullscreenAds];
    [VSAdIntShowManager closeFullscreenAds];
}

#pragma mark - event
- (void)eventWithEventName:(NSString *)eventName placeType:(VSAdShowPlaceType)placeType unitId:(NSString *)unitId {
    if ([[HFAdmobManager shareInstance].delegate respondsToSelector:@selector(admobManagerEventName:placeType:unitId:)]) {
        [[HFAdmobManager shareInstance].delegate admobManagerEventName:@"start_request" placeType:placeType unitId:unitId];
    }
}

#pragma mark - connectVpnLimit
+ (void)finishConnectAuthor {
    [VSAdConfig finishConnectAuthor];
}

#pragma mark - lazy
- (VSAdPlaceManager *)startPlaceManager {
    if (!_startPlaceManager) {
        _startPlaceManager = [[VSAdPlaceManager alloc] init];
    }
    return _startPlaceManager;
}

- (VSAdPlaceManager *)connectPlaceManager {
    if (!_connectPlaceManager) {
        _connectPlaceManager = [[VSAdPlaceManager alloc] init];
    }
    return _connectPlaceManager;
}

- (VSAdPlaceManager *)extraPlaceManager {
    if (!_extraPlaceManager) {
        _extraPlaceManager = [[VSAdPlaceManager alloc] init];
    }
    return _extraPlaceManager;
}

- (VSAdPlaceManager *)homePlaceManager {
    if (!_homePlaceManager) {
        _homePlaceManager = [[VSAdPlaceManager alloc] init];
    }
    return _homePlaceManager;
}

- (VSAdPlaceManager *)cellPlaceManager {
    if (!_cellPlaceManager) {
        _cellPlaceManager = [[VSAdPlaceManager alloc] init];
    }
    return _cellPlaceManager;
}

- (VSAdPlaceManager *)bannerPlaceManager {
    if (!_bannerPlaceManager) {
        _bannerPlaceManager = [[VSAdPlaceManager alloc] init];
    }
    return _bannerPlaceManager;
}
@end
