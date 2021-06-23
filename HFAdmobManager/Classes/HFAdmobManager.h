//
//  HFAdmobManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "VSAdNavTemplateHomeBottom.h"
#import "VSAdNavTemplateLayoutDelegate.h"



NS_ASSUME_NONNULL_BEGIN

static NSString *kNotificationNamePartAdLoadSuccussKey = @"kNotificationNamePartAdLoadSuccussKey";
static NSString *kNotificationNameFullScreenAdLoadSuccussKey = @"kNotificationNameFullScreenAdLoadSuccussKey";


static NSString *kHFAdmobEvent_startRequest = @"event_startRequest";
static NSString *kHFAdmobEvent_receiveAdFail = @"event_receiveAdFail";
static NSString *kHFAdmobEvent_receiveAd = @"event_receiveAd";

static NSString *kHFAdmobEvent_adClick = @"event_adClick";
static NSString *kHFAdmobEvent_adHidden = @"event_adHidden";
static NSString *kHFAdmobEvent_adShow = @"event_adShow";


typedef BOOL (^OpenDebugModeHandler)(void);


@protocol HFAdmobManagerEventDelegate <NSObject>

/// 广告相关的事件
/// @param eventName start_request、adClick、adHidden、adShow、receiveAdFail、receiveAd
/// @param placeType placeType description
/// @param unitId unitId description
- (void)admobManagerEventName:(NSString *)eventName
                    placeType:(VSAdShowPlaceType)placeType
                       unitId:(NSString *)unitId;
@end

@interface HFAdmobManager : NSObject {
    BOOL _isDEBUGMode;
}

+ (instancetype)shareInstance;

@property (nonatomic, weak) id<HFAdmobManagerEventDelegate> delegate;


#pragma mark - load
+ (void)preloadAllAds;
+ (void)reloadAdsWithPlaceType:(VSAdShowPlaceType)placeType
                        notify:(BOOL)notify;
+ (void)reloadAdsWithPlaceType:(VSAdShowPlaceType)placeType
                        notify:(BOOL)notify
             completionHandler:(void (^ _Nullable)(BOOL success)) completionHandler;

+ (void)reloadBannerAdsWithPlaceType:(VSAdShowPlaceType)placeType
                         containView:(UIView * _Nullable)containView
                      rootController:(UIViewController *)rootController
                   completionHandler:(void (^ _Nullable)(BOOL success)) completionHandler;
#pragma mark - show
+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType
                  controller:(UIViewController *)controller;

+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType
                 containView:(UIView *)containView
                    delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate> _Nullable)delegate;

+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType
                 containView:(UIView *)containView
                    delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate> _Nullable)delegate
              layoutDelegate:(id<VSAdNavTemplateLayoutDelegate> _Nullable)layoutDelegate;

+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType
                        cell:(UITableViewCell *)cell;
+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType
                        cell:(UITableViewCell *)cell
              layoutDelegate:(id<VSAdNavTemplateLayoutDelegate> _Nullable)layoutDelegate;

+ (BOOL)isReadyWithPlaceType:(VSAdShowPlaceType)placeType;

+ (void)closeFullScrenAds;
#pragma mark -

#pragma mark - connectVpnLimit
+ (void)finishConnectAuthor;


/// 是关闭广告，处理VIP 情况
@property (nonatomic, copy) BOOL (^closeAdsHandler)(void);

/// 打开测试模式，用测试ID拉取广告
- (void)openDebugModeWithHandler:(OpenDebugModeHandler)handler;
- (BOOL)isDEBUGMode;

- (void)eventWithEventName:(NSString *)eventName placeType:(VSAdShowPlaceType)placeType unitId:(NSString *)unitId;

@end

NS_ASSUME_NONNULL_END
