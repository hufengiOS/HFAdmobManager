//
//  HFDeviceInfo.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFDeviceInfo : NSObject

+ (NSString *)getDeviceIDInKeychain;
+ (NSString *)getAPIVersion;
+ (NSString *)getSdkVersion;
+ (NSString *)iOSVersion;

/// 获取运营商编号
+ (NSString *)getDeviceIMSI;
+ (NSString *)getDeviceISOCountryCode;

@end

NS_ASSUME_NONNULL_END
