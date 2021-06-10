//   
//   HFAdsDisplayRatio.m
//   VPNProject
//   
//   Created  by hf on 2021/1/19 10:21
//   Copyright © 2021 Snake. All rights reserved.
//			🐶
//   行行无bug 类类低耦合

   

#import "HFAdsDisplayRatio.h"
#import "VSAdMacro.h"

@interface HFAdsDisplayRatio()

@property (nonatomic, strong) HFAdsDisplayRatioModel *homeModel;
@property (nonatomic, strong) HFAdsDisplayRatioModel *startModel;
@property (nonatomic, strong) HFAdsDisplayRatioModel *connectModel;
@property (nonatomic, strong) HFAdsDisplayRatioModel *extraModel;
@property (nonatomic, strong) HFAdsDisplayRatioModel *openModel;

@property (nonatomic, assign) NSUInteger totalShowNum;
@property (nonatomic, assign) NSUInteger totalCacheNum;

@end

@implementation HFAdsDisplayRatio

+ (instancetype)shareInstance {
    static HFAdsDisplayRatio *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HFAdsDisplayRatio alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)addRequestWithAdPlace:(VSAdShowPlaceType)adPlace unitType:(VSAdUnitType)unitType {
    HFAdsDisplayRatio *manager = [self shareInstance];
    
    if (adPlace == VSAdShowPlaceTypeFullStart) {
        manager.startModel.requestNum ++;
    } else if (adPlace == VSAdShowPlaceTypeFullConnect) {
        manager.connectModel.requestNum ++;
    } else if (adPlace == VSAdShowPlaceTypeFullExtra) {
        manager.extraModel.requestNum ++;
    }
    manager.totalCacheNum ++;
//    NSAssert(adPlace.length > 0, @"广告位置信息不全");
    [self printLog];
}

+ (void)addShowWithAdPlace:(VSAdShowPlaceType)adPlace unitType:(VSAdUnitType)unitType {
    HFAdsDisplayRatio *manager = [self shareInstance];
    
    if (adPlace == VSAdShowPlaceTypeFullStart) {
        manager.startModel.showNum ++;
    } else if (adPlace == VSAdShowPlaceTypeFullConnect) {
        manager.connectModel.showNum ++;
    } else if (adPlace == VSAdShowPlaceTypeFullExtra) {
        manager.extraModel.showNum ++;
    }
    manager.totalShowNum ++;
//    NSAssert(adPlace.length > 0, @"广告位置信息不全");
    [self printLog];
}

+ (void)printLog {
    HFAdsDisplayRatio *manager = [self shareInstance];
    
    HFAd_DebugLog(@"请求数%tu 展示数%lu 展示率%lf", manager.totalCacheNum, manager.totalShowNum, manager.totalShowNum/(manager.totalCacheNum * 1.));
}

- (HFAdsDisplayRatioModel *)startModel {
    if (!_startModel) {
        _startModel = [[HFAdsDisplayRatioModel alloc] init];
    }
    return _startModel;
}

- (HFAdsDisplayRatioModel *)connectModel {
    if (!_connectModel) {
        _connectModel = [[HFAdsDisplayRatioModel alloc] init];
    }
    return _connectModel;
}

- (HFAdsDisplayRatioModel *)homeModel {
    if (!_homeModel) {
        _homeModel = [[HFAdsDisplayRatioModel alloc] init];
    }
    return _homeModel;
}

- (HFAdsDisplayRatioModel *)openModel {
    if (!_openModel) {
        _openModel = [[HFAdsDisplayRatioModel alloc] init];
    }
    return _openModel;
}

- (HFAdsDisplayRatioModel *)extraModel {
    if (!_extraModel) {
        _extraModel = [[HFAdsDisplayRatioModel alloc] init];
    }
    return _extraModel;
}

@end

@implementation HFAdsDisplayRatioModel



@end
