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

//typedef NS_ENUM(NSUInteger, VSAdShowType) {
//    VSAdShowTypeFullScreen, // 全屏广告
//    VSAdShowTypePart        // 局部原生广告
//};

typedef NS_ENUM(NSUInteger, VSAdShowPlaceType) {
    VSAdShowPlaceTypeUnknown,           // 未知
    VSAdShowPlaceTypeFullStart,         // 全屏广告
    VSAdShowPlaceTypePartHome,          // 局部首页广告
    VSAdShowPlaceTypeFullConnect,       // 全屏连接广告
    VSAdShowPlaceTypeFullExtra,         // 全屏返回广告
    VSAdShowPlaceTypePartOther          // 局部其他广告
};

@class VSAdNavTemplateHomeBottom;

@protocol VSAdNavTemplateHomeBottomClickDelegate <NSObject>
- (void)clickAdInHomeBottomAds:(VSAdNavTemplateHomeBottom *)homeBottomAds;
@end

//kWeakSelf
#define HFAdWeakSelf(type)          __weak typeof(type) weak##type = type;
#define HFAdStrongSelf(type)        __strong typeof(type) strong##type = weak##type;


#ifdef DEBUG

#define HFAdDebugLog(s, ... ) {\
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
#define HFAdDebugLog(s, ... )
#endif

#pragma mark - 布局相关
#define isIPad                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kScreenWidth            (!isIPad ? 375 : 768)
#define kScreenHeight           (!isIPad ? (isFullScreenDevice ? 812 : 667) : 1024)

#define kScaleWidth(W)          roundf(kScreenWidthRatio*(W))
#define kScaleHeight(H)         roundf(kScreenHeightRatio*(H))
#define kScaleWidthWith(iphoneValue, ipadValue)         (isIPad ? kScaleWidth(ipadValue) : kScaleWidth(iphoneValue))
#define kScaleHeightWith(iphoneValue, ipadValue)        (isIPad ? kScaleHeight(ipadValue) : kScaleHeight(iphoneValue))

#define kSizeValue(iphoneValue, ipadValue)        (isIPad ? ipadValue : iphoneValue)

#define kFrameValue(iphoneNormalScreenValue, iphoneFullScreenValue, iPadNormalScreenValue, iPadFullScreenValue)      (isIPad ? (isFullScreenDevice ? iPadFullScreenValue:iPadNormalScreenValue) : (isFullScreenDevice ? iphoneFullScreenValue: iphoneNormalScreenValue))

// MainScreen Height&Width
#define MainScreen_Height       [[UIScreen mainScreen] bounds].size.height
#define MainScreen_Width        [[UIScreen mainScreen] bounds].size.width
#define MainScreen_bounds       [[UIScreen mainScreen] bounds]

#define kScreenWidthRatio       (UIScreen.mainScreen.bounds.size.width / kScreenWidth)
#define kScreenHeightRatio      (UIScreen.mainScreen.bounds.size.height / kScreenHeight)
#define WidthHeightRatio        MainScreen_Width/MainScreen_Height



// 字体大小(常规/粗体)
#define FONTSYSTEMBold(FONTSIZE)        [UIFont boldSystemFontOfSize:kScreenWidthRatio*(FONTSIZE)]
#define FONT(FONTSIZE)                  [UIFont systemFontOfSize:kScreenWidthRatio*(FONTSIZE)]
#define FONTWeight(FONTSIZE, Weight)    [UIFont systemFontOfSize:kScreenWidthRatio*(FONTSIZE) weight:(Weight)]

#define FONTPingFang(FONTSIZE)          [UIFont fontWithName:@"PingFang SC" size:kScreenWidthRatio*(FONTSIZE)]
#define FONTMedium(FONTSIZE)            [UIFont fontWithName:@"PingFangSC-Medium" size:kScreenWidthRatio*(FONTSIZE)]
#define FONTRegular(FONTSIZE)           [UIFont fontWithName:@"PingFangSC-Regular" size:kScreenWidthRatio*(FONTSIZE)]


#endif /* VSAdMacro_h */
