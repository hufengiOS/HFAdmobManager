#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HFAdmobManager.h"
#import "HFAdmobManagerHeader.h"
#import "VSAdMacro.h"
#import "Ad_AppConfiger.h"
#import "NSArray+ad_Map.h"
#import "VSAdPlaceManager.h"
#import "VSAdUnit.h"
#import "HFAdsDisplayRatio.h"
#import "VSAdCacheManager.h"
#import "VSAdConfig.h"
#import "VSAdBannerLoader.h"
#import "VSAdIntLoader.h"
#import "VSAdNavLoader.h"
#import "VSAdBannerShowManager.h"
#import "VSAdIntShowManager.h"
#import "VSAdNavShowManager.h"
#import "VSAdShowClickAdsManager.h"
#import "VSAdNavTemplateBase.h"
#import "VSAdNavTemplateCell.h"
#import "VSAdNavTemplateFullScreen.h"
#import "VSAdNavTemplateHomeBottom.h"
#import "VSAdNavTemplateLayoutDelegate.h"
#import "VSTableAdsCell.h"
#import "VSGlobalConfigManager.h"
#import "VSGlobalConfigModel.h"

FOUNDATION_EXPORT double HFAdmobManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char HFAdmobManagerVersionString[];

