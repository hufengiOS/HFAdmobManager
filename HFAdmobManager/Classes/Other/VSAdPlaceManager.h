//
//  VSAdPlaceManager.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/25.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSAdPlaceManager : NSObject

//+ (instancetype)shareInstance;
//- (void)loadAdsWithPlaceType:(VSAdShowPlaceType)placeType;
//- (void)loadAdsWithPlaceType:(VSAdShowPlaceType)placeType completionHandler:(void (^ _Nullable)(BOOL success))completionHandler;
- (void)loadAdsWithPlaceType:(VSAdShowPlaceType)placeType completionHandler:(void (^ _Nullable)(BOOL success))completionHandler;

//- (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType controller:(UIViewController *_Nullable)controller;
//- (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType containView:(UIView *)containView;
//- (BOOL)showAdsWithPlaceType:(VSAdShowPlaceType)placeType controller:(UIViewController * _Nullable)controller containView:(UIView * _Nullable)containView;


@end

NS_ASSUME_NONNULL_END
