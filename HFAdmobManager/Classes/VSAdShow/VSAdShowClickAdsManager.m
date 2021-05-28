//
//  VSAdShowClickAdsManager.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/27.
//

#import "VSAdShowClickAdsManager.h"
#import "VSAdUnit.h"
//#import "NSDate+VSHelper.h"
#import "VSAdMacro.h"
#import "VSGlobalConfigManager.h"
#import "VSAdConfig.h"


static NSString *const kClickAdsNumber = @"kClickAdsNumber";
static NSString *const kShowAdsNumber = @"kShowAdsNumber";


@implementation VSAdShowClickAdsManager

+ (NSInteger)adClickLimitCount {
    return [VSGlobalConfigManager shareInstance].configModel.vgfCkLimit;
}

+ (BOOL)allowClickWithPlaceType:(VSAdShowPlaceType)placeType {
    
    HFAd_DebugLog(@"%@ click number = %ld %ld", ADPlaceTypeString(placeType), (long)[VSAdShowClickAdsManager numberOfClickAdsWithPlaceType:placeType], (long)[VSAdShowClickAdsManager adClickLimitCount])
    return [VSAdShowClickAdsManager adClickLimitCount] == 0 ||
    [VSAdShowClickAdsManager numberOfClickAdsWithPlaceType:placeType] < [VSAdShowClickAdsManager adClickLimitCount];
}

#pragma mark - 广告点击次数的限制
+ (NSInteger)numberOfClickAdsWithPlaceType:(VSAdShowPlaceType)placeType {
    return [self numberOfItemWithSaveKey:[kClickAdsNumber stringByAppendingString:ADPlaceTypeString(placeType)]];
}

+ (void)cleanNumberOfClickAdsWithPlaceType:(VSAdShowPlaceType)placeType {
    [self cleanNumberOfItemWithSaveKey:[kClickAdsNumber stringByAppendingString:ADPlaceTypeString(placeType)]];
}

+ (NSInteger)addClickAdsWithPlaceType:(VSAdShowPlaceType)placeType {
    
    NSAssert(placeType != VSAdShowPlaceTypeUnknown, @"");
    return [self addCountOfItemWithSaveKey:[kClickAdsNumber stringByAppendingString:ADPlaceTypeString(placeType)]];
}

#pragma mark - 广告展示次数的限制
+ (NSInteger)numberOfShowAdsWithPlaceType:(VSAdShowPlaceType)placeType {
    return [self numberOfItemWithSaveKey:[kShowAdsNumber stringByAppendingString:ADPlaceTypeString(placeType)]];
}

+ (void)cleanNumberOfShowAdsWithPlaceType:(VSAdShowPlaceType)placeType {
    [self cleanNumberOfItemWithSaveKey:[kShowAdsNumber stringByAppendingString:ADPlaceTypeString(placeType)]];
}

+ (NSInteger)addNumberOfShowAdsWithPlaceType:(VSAdShowPlaceType)placeType {
    return [self addCountOfItemWithSaveKey:[kShowAdsNumber stringByAppendingString:ADPlaceTypeString(placeType)]];
}

#pragma mark - ------- 管理广告点击次数 ---------
+ (NSInteger)numberOfItemWithSaveKey:(NSString *)saveKey {
    
    long lastTimeStamp = [VSAdUnit intValueForKey:[self timeStampeWithSaveKey:saveKey]];
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:lastTimeStamp];
    
    
    NSUInteger lastDay = [self dayForDate:lastDate];
    NSDate *nowDate = [NSDate date];
    NSUInteger nowDay = [self dayForDate:nowDate];
    

    if (nowDay > lastDay) {
        // 一天之后清除
        [self cleanNumberOfItemWithSaveKey:saveKey];
        return [VSAdUnit intValueForKey:saveKey];
    } else {
        return [VSAdUnit intValueForKey:saveKey];
    }
}

+ (NSString *)timeStampeWithSaveKey:(NSString *)saveKey {
    return [saveKey stringByAppendingString:@"_timeStamp"];
}

+ (void)cleanNumberOfItemWithSaveKey:(NSString *)saveKey {
    [VSAdUnit saveWithInt:0 key:saveKey];
    [VSAdUnit saveWithInt:[[NSDate date] timeIntervalSince1970] key:[self timeStampeWithSaveKey:saveKey]];
}

+ (NSInteger)addCountOfItemWithSaveKey:(NSString *)saveKey {
    NSInteger number = [VSAdUnit intValueForKey:saveKey];
    // 定点清空
    
    long lastTimeStamp = [VSAdUnit intValueForKey:[self timeStampeWithSaveKey:saveKey]];
    BOOL isFirst = [self isFirstTodayWithTimeStamp:lastTimeStamp];
    if (isFirst) {
        // 一天之后清除
        [VSAdUnit saveWithInt:1 key:saveKey];
    } else {
        number = number + 1;
        [VSAdUnit saveWithInt:number key:saveKey];
    }
    [VSAdUnit saveWithInt:[[NSDate date] timeIntervalSince1970] key:[self timeStampeWithSaveKey:saveKey]];
    return number;
}

/// 是否是当前时间戳的上一天
/// @param timeStamp 时间戳
+ (BOOL)isFirstTodayWithTimeStamp:(NSTimeInterval)timeStamp {
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSUInteger lastDay = [self dayForDate:lastDate];
    
    NSDate *nowDate = [NSDate date];
    NSUInteger nowDay = [self dayForDate:nowDate];
    if (nowDay > lastDay) {
        return YES;
    } else {
        return NO;
    }
}


+ (NSUInteger)dayForDate:(NSDate *)date {
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
    return [weekdayComponents day];
}

+ (NSCalendar *)sharedCalendar {
    static dispatch_once_t onceToken;
    static NSCalendar *_calendar = nil;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if (_calendar == nil) {
                _calendar = [NSCalendar currentCalendar];
            }
        }
    });
    return _calendar;
}

@end
