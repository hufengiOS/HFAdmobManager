//
//  HFAdmobManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "VSAdNavTemplateHomeBottom.h"



NS_ASSUME_NONNULL_BEGIN

static NSString *kNotificationNamePartAdLoadSuccussKey = @"kNotificationNamePartAdLoadSuccussKey";
static NSString *kNotificationNameFullScreenAdLoadSuccussKey = @"kNotificationNameFullScreenAdLoadSuccussKey";

@interface HFAdmobManager : NSObject {
    BOOL _isDEBUGMode;
}

#pragma mark - load
+ (void)preloadAllAds;
+ (void)reloadAdsWithPlaceType:(VSAdShowPlaceType)placeType notify:(BOOL)notify;
+ (void)reloadAdsWithPlaceType:(VSAdShowPlaceType)placeType notify:(BOOL)notify completionHandler:(void (^ _Nullable)(BOOL success)) completionHandler;

#pragma mark - show
+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType controller:(UIViewController *_Nullable)controller;
+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType containView:(UIView *)containView delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate>)delegate;
+ (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType cell:(UITableViewCell *)cell;
+ (BOOL)isReadyWithPlaceType:(VSAdShowPlaceType)placeType;

+ (void)closeFullScrenAds;
#pragma mark -

#pragma mark - connectVpnLimit
+ (void)finishConnectAuthor;


/// 打开测试模式，用测试ID拉取广告
+ (void)openDebugMode;
+ (BOOL)isDEBUGMode;





@end

NS_ASSUME_NONNULL_END
