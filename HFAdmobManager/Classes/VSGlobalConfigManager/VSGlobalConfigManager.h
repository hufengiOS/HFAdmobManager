//
//  VSGlobalConfigManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/17.
//

#import <Foundation/Foundation.h>
#import "VSGlobalConfigModel.h"
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN


static NSString *kNotificationNameVSGlobalConfigManagerLoadSuccess = @"kNotificationNameVSGlobalConfigManagerLoadSuccess";

typedef NSDictionary * _Nullable (^kDefaultConfigHandler)(void);



@interface VSGlobalConfigManager : NSObject


+ (instancetype)shareInstance;
- (void)configWithDic:(NSDictionary *)dic;
- (VSGlobalConfigModel *)configModel;

#pragma mark - 付费相关
- (VSGlobalConfigPayItemModel *)itemModelForIntroducePay;
- (VSGlobalConfigPayItemModel *)itemModelForPayPage;
- (NSArray<VSGlobalConfigPayItemModel *> *)itemArrayForPay;

#pragma mark - 广告相关
- (NSArray <VSGlobalConfigAdsConfigAdPlaceModel *> *)adPlacesWithPlaceType:(VSAdShowPlaceType)placeType;

#pragma mark - vp服务相关
/// vpn 服务优先连接国家
+ (NSString *)VPNOptimalConnectCountry;

@property (nonatomic, copy) kDefaultConfigHandler defaultConfigHandler;
/// 后台参数和具体类型的对应关系
@property (nonatomic, copy) VSAdShowPlaceType (^keyAndValueHandler)(NSString *adName);

@end

NS_ASSUME_NONNULL_END
