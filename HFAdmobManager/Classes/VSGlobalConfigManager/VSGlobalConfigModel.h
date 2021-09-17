//
//  VSGlobalConfigModel.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/17.
//

#import <Foundation/Foundation.h>
//#import "VSAdUnit.h"
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@class VSGlobalConfigAdsConfigModel;
@class VSGlobalConfigCloseBtnModel;
@class VSGlobalConfigAdsConfigAdPlaceModel;
@class VSGlobalConfigPayItemModel;
@class VSGlobalConfigPayModel;
@class VSGlobalConfigVersionModel;

@interface VSGlobalConfigModel : NSObject

@property (nonatomic, assign) int status;

@property (nonatomic, strong) NSArray <VSGlobalConfigAdsConfigModel *> *adCfgs;

/// 点击次数限制(全局)
@property (nonatomic, assign) int vgfCkLimit;

/// 首次连接前是否展示开屏广告
@property (nonatomic, assign) int vgfConnOpAd;

/// 优先连接国家
@property (nonatomic, strong) NSString *vgfCountryConn;

/// 拉取间隔:(分钟)
@property (nonatomic, assign) int vgfInterval;

/// 配置名称
@property (nonatomic, strong) NSString *vgfName;
/// 启动动画时长
@property (nonatomic, assign) int vgfOpTime;


@property (nonatomic, strong) VSGlobalConfigPayModel *vpnGlobalSubConfig;
@property (nonatomic, strong) VSGlobalConfigVersionModel *configForceUpdate;
@end


@interface VSGlobalConfigAdsConfigModel : NSObject

@property (nonatomic, strong) VSGlobalConfigCloseBtnModel *navCloseBtn;



@property (nonatomic, assign) BOOL adSwitch;
@property (nonatomic, strong) NSString *adPlace;
@property (nonatomic, strong) NSArray <VSGlobalConfigAdsConfigAdPlaceModel *> *adSource;



- (VSAdShowPlaceType)adNameType;


@end

@interface VSGlobalConfigCloseBtnModel : NSObject


/// small/big/normal
@property (nonatomic, strong) NSString *iconType;
@property (nonatomic, assign) BOOL isIcon;
@property (nonatomic, assign) int textEdgeSpace;

@end

@interface VSGlobalConfigAdsConfigAdPlaceModel : NSObject


@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, assign) int weight;
@property (nonatomic, assign) int closeSize;

@property (nonatomic, strong) NSString *type;

- (VSAdUnitType)adUnitType;
@end

@interface VSGlobalConfigPayModel : NSObject

@property (nonatomic, strong) NSString *defaultSelect;
@property (nonatomic, strong) NSArray<VSGlobalConfigPayItemModel *> *itemList;
@property (nonatomic, strong) NSArray<NSString *> *itemOrder;

@property (nonatomic, assign) int openPay;
@property (nonatomic, strong) NSString *payPassword;
@property (nonatomic, strong) NSString *paymentIntroduce_productId;

- (NSArray<NSString *> *)itemProductIdArray;
@end

@interface VSGlobalConfigPayItemModel : NSObject

@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *localPrice;
@property (nonatomic, strong) NSString *placeholderStr;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *saveInfo;

@end

@interface VSGlobalConfigVersionModel : NSObject

/// 是否强制更新
@property (nonatomic, assign) BOOL isForce;
@property (nonatomic, assign) int appVerMax;
@property (nonatomic, assign) int appVerMin;
// 包名
@property (nonatomic, strong) NSString *packageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;

@end


NS_ASSUME_NONNULL_END
