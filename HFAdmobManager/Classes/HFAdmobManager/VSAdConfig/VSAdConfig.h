//
//  VSAdConfig.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@class VSGlobalConfigCloseBtnModel;
@interface VSAdConfig : NSObject

+ (void)configAds;

+ (BOOL)allowRequestWithShowPlaceType:(VSAdShowPlaceType)placeType;
+ (BOOL)allowShowWithShowPlaceType:(VSAdShowPlaceType)placeType;

+ (VSGlobalConfigCloseBtnModel *)closeBtnModelWithPlaceType:(VSAdShowPlaceType)placeType;

+ (BOOL)openAdBeforeConnect;
+ (void)finishConnectAuthor;
+ (BOOL)getConnectAuthorStatus;

+ (NSString *)nameWithPlaceType:(VSAdShowPlaceType)placeType;
+ (NSString *)nameWithUnitType:(VSAdUnitType)unitType;
@end

NS_ASSUME_NONNULL_END
