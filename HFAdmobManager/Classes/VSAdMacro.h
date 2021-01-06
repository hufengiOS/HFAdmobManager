//
//  VSAdMacro.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#ifndef VSAdMacro_h
#define VSAdMacro_h


typedef NS_ENUM(NSUInteger, VSAdUnitType) {
    VSAdUnitTypeUnknown,
    VSAdUnitTypeNav,
    VSAdUnitTypeInt
};

typedef NS_ENUM(NSUInteger, VSAdShowPlaceType) {
    VSAdShowPlaceTypeUnknown,           // 未知
    VSAdShowPlaceTypeFullStart,         // 全屏广告
    VSAdShowPlaceTypePartHome,          // 局部首页广告
    VSAdShowPlaceTypeFullConnect,       // 全屏连接广告
    VSAdShowPlaceTypeFullExtra,         // 全屏返回广告
    VSAdShowPlaceTypePartOther          // 局部其他广告
};

#ifdef DEBUG

#define HFAd_DebugLog(s, ... ) {\
\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"HH:mm:ss:SSSSSS"]; \
NSDate *date = [NSDate date];\
NSTimeZone *zone = [NSTimeZone systemTimeZone];\
NSTimeInterval interval = [zone secondsFromGMTForDate:date];\
NSDate *current = [date dateByAddingTimeInterval:interval];\
NSString *str = [dateFormatter stringFromDate:current];\
printf("< %s:(%d) %s %s> Debug_log %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__ ,__func__, [str UTF8String], [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );\
}
#else
#define HFAd_DebugLog(s, ... )
#endif

#pragma mark - 布局相关
#define HF_isIPad                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define HF_kScreenWidth            (!HF_isIPad ? 375 : 768)
#define HF_kScreenHeight           (!HF_isIPad ? (HF_isFullScreenDevice ? 812 : 667) : 1024)

#define HF_kScaleWidth(W)          roundf(HF_kScreenWidthRatio*(W))
#define HF_kScaleHeight(H)         roundf(HF_kScreenHeightRatio*(H))
#define HF_kScaleWidthWith(iphoneValue, ipadValue)         (HF_isIPad ? HF_kScaleWidth(ipadValue) : HF_kScaleWidth(iphoneValue))
#define HF_kScaleHeightWith(iphoneValue, ipadValue)        (HF_isIPad ? HF_kScaleHeight(ipadValue) : HF_kScaleHeight(iphoneValue))

#define HF_kFrameValue(iphoneNormalScreenValue, iphoneFullScreenValue, iPadNormalScreenValue, iPadFullScreenValue)      (HF_isIPad ? (HF_isFullScreenDevice ? iPadFullScreenValue:iPadNormalScreenValue) : (HF_isFullScreenDevice ? iphoneFullScreenValue: iphoneNormalScreenValue))

// MainScreen Height&Width
#define HF_MainScreen_Height       [[UIScreen mainScreen] bounds].size.height
#define HF_MainScreen_Width        [[UIScreen mainScreen] bounds].size.width

#define HF_kScreenWidthRatio       (UIScreen.mainScreen.bounds.size.width / HF_kScreenWidth)
#define HF_kScreenHeightRatio      (UIScreen.mainScreen.bounds.size.height / HF_kScreenHeight)






#endif /* VSAdMacro_h */
