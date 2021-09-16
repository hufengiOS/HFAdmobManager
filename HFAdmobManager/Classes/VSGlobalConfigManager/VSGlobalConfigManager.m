//
//  VSGlobalConfigManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/17.
//

#import "VSGlobalConfigManager.h"
#import "VSGlobalConfigModel.h"
#import <MJExtension/MJExtension.h>
#import "VSAdUnit.h"

static NSString *const kGlobalConfigFileName = @"kGlobalConfigFileName";




@interface VSGlobalConfigManager ()

@property (nonatomic, strong) VSGlobalConfigModel *model;

@property (nonatomic, strong) VSGlobalConfigPayItemModel *introduceProduct;
@property (nonatomic, strong) VSGlobalConfigPayItemModel *payPageProduce;

@end

@implementation VSGlobalConfigManager

+ (instancetype)shareInstance {
    static VSGlobalConfigManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)configWithDic:(NSDictionary *)dic {
    if (dic) {
        [VSAdUnit writeFileWithFileName:kGlobalConfigFileName dic:dic];
        self.model = [VSGlobalConfigModel mj_objectWithKeyValues:dic];
    }
}

- (VSGlobalConfigModel *)configModel {
    if (self.model) {
        return self.model;
    } else {
        NSDictionary *cacheDic = [VSAdUnit readFileWithFileName:kGlobalConfigFileName];
        VSGlobalConfigModel *model;
        if (!cacheDic) {
            NSDictionary *localDic = !_defaultConfigHandler ? nil : _defaultConfigHandler();
            if ([localDic.allKeys containsObject:@"data"]) {
                model = [VSGlobalConfigModel mj_objectWithKeyValues:localDic[@"data"]];
            }
        } else {
            model = [VSGlobalConfigModel mj_objectWithKeyValues:cacheDic];
        }
        _model = model;
        return _model;
    }
}

- (VSGlobalConfigPayItemModel *)itemModelForIntroducePay {
    VSGlobalConfigModel *configModel = self.configModel;
    [configModel.vpnGlobalSubConfig.itemList enumerateObjectsUsingBlock:^(VSGlobalConfigPayItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.productId isEqualToString:configModel.vpnGlobalSubConfig.paymentIntroduce_productId]) {
            self.introduceProduct = obj;
            *stop = YES;
        }
    }];
    return self.introduceProduct;
}

- (VSGlobalConfigPayItemModel *)itemModelForPayPage {
    if (!self.payPageProduce) {
        VSGlobalConfigModel *configModel = self.configModel;
        [configModel.vpnGlobalSubConfig.itemList enumerateObjectsUsingBlock:^(VSGlobalConfigPayItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.productId isEqualToString:configModel.vpnGlobalSubConfig.defaultSelect]) {
                self.payPageProduce = obj;
                *stop = YES;
            }
        }];
    }
    return self.payPageProduce;
}

- (NSArray<VSGlobalConfigPayItemModel *> *)itemArrayForPay {
    VSGlobalConfigModel *configModel = self.configModel;
    NSMutableArray<VSGlobalConfigPayItemModel *> *array = [[NSMutableArray alloc] init];
    
    [configModel.vpnGlobalSubConfig.itemOrder enumerateObjectsUsingBlock:^(NSString * _Nonnull productId, NSUInteger idx, BOOL * _Nonnull superStop) {
        [configModel.vpnGlobalSubConfig.itemList enumerateObjectsUsingBlock:^(VSGlobalConfigPayItemModel * _Nonnull itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([productId isEqualToString:itemModel.productId]) {
                [array addObject:itemModel];
                *stop = YES;
            }
        }];
    }];
    
    return array;
}

#pragma mark - 广告相关
- (NSArray <VSGlobalConfigAdsConfigAdPlaceModel *> *)adPlacesWithPlaceType:(VSAdShowPlaceType)placeType {
    VSGlobalConfigModel *configModel = self.configModel;
    __block NSArray <VSGlobalConfigAdsConfigAdPlaceModel *> *array = [[NSArray alloc] init];
    [configModel.adCfgs enumerateObjectsUsingBlock:^(VSGlobalConfigAdsConfigModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.adNameType == placeType) {
            array = obj.adSource;
            *stop = YES;
        }
    }];
    
    array = [array sortedArrayUsingComparator:^NSComparisonResult(VSGlobalConfigAdsConfigAdPlaceModel *_Nonnull obj1, VSGlobalConfigAdsConfigAdPlaceModel *_Nonnull obj2) {
        return obj1.weight < obj2.weight;
    }];
    return array;
}

/// vpn 服务优先连接国家
+ (NSString *)VPNOptimalConnectCountry {
    return [VSGlobalConfigManager shareInstance].configModel.vgfCountryConn;
}
@end
