//
//  VSAdNavShowManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavShowManager.h"
#import "VSAdNavTemplateBase.h"
#import "VSAdNavTemplateFullScreen.h"
#import "VSAdNavTemplateHomeBottom.h"
#import "VSAdNavTemplateCell.h"


@interface VSAdNavShowManager () {
    
}
@property (nonatomic, strong) VSAdNavTemplateFullScreen *fullScreen;
@property (nonatomic, strong) VSAdNavTemplateHomeBottom *homeBottom;
@property (nonatomic, strong) VSAdNavTemplateCell *cellTemplate;



@end

@implementation VSAdNavShowManager

+ (instancetype)shareInstance {
    static VSAdNavShowManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VSAdNavShowManager alloc] init];
        manager.fullScreen = [[VSAdNavTemplateFullScreen alloc] init];
        manager.cellTemplate = [[VSAdNavTemplateCell alloc] init];
        manager.homeBottom = [[VSAdNavTemplateHomeBottom alloc] init];
    });
    return manager;
}

/// 展示原生全屏广告
/// @param nativeAd 广告数据
/// @param controller 展示的控制器
+ (void)showNavAdWithNav:(GADUnifiedNativeAd *)nativeAd adUnit:(NSString *)adUnit placeType:(VSAdShowPlaceType)placeType controller:(UIViewController *)controller {
    VSAdNavTemplateFullScreen *fullScreen = [VSAdNavShowManager shareInstance].fullScreen;
    fullScreen.adUnitId = adUnit;
    [fullScreen showInController:controller placeType:placeType nativeAd:nativeAd];
}

+ (void)showNavAdWithNav:(GADUnifiedNativeAd *)nativeAd adUnit:(NSString *)adUnit containView:(UIView *)containView delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate>)delegate {
    VSAdNavTemplateHomeBottom *homeBottom = [VSAdNavShowManager shareInstance].homeBottom;
    homeBottom.adUnitId = adUnit;
    [homeBottom showInContainView:containView nativeAd:nativeAd delegate:delegate];
    // 处理home广告点击的代理
//    [VSAdNavShowManager shareInstance].homeBottomClickdelgate = delegate;
}

+ (BOOL)showNavAdWithNav:(GADUnifiedNativeAd *)nativeAd adUnit:(NSString *)adUnit cell:(UITableViewCell *)cell {
    VSAdNavTemplateCell *cellTemplate = [VSAdNavShowManager shareInstance].cellTemplate;
    cellTemplate.adUnitId = adUnit;
    return [cellTemplate showAdsInCell:cell nativeAd:nativeAd];
}

+ (void)closeFullscreenAds {
    VSAdNavTemplateFullScreen *fullScreen = [VSAdNavShowManager shareInstance].fullScreen;
    [fullScreen closeFullscreenAds];
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"--- 释放 --- %@",self);
#endif
}


@end
