//
//  HFDeviceInfo.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/5.
//

#import "HFDeviceInfo.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

/**
 获取 Build 构建版本号 a.b.c
 a:用来区别后台数据，接口需要，每个版本递增；
 b:区别不同的IPA文件，避免上传冲突；
 c: kSwitchIsDEBUG YES:1 测试版本 NO:2 正式版本
*/
#define kVersionCodeValue [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kBundleIdentifier [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

@implementation HFDeviceInfo


// 接口版本号 13.1 前面是版本号，后面防止提交重复
+ (NSString *)getAPIVersion {
    NSString *version = kVersionCodeValue;
    NSRange range = [kVersionCodeValue rangeOfString:@"."];
    if (range.length > 0) {
        NSString *apiVersion = [version substringToIndex:range.location];
        return apiVersion;
    } else {
        return version;
    }
}

+ (NSString *)getSdkVersion {
    NSString *deviceVersion = [self iOSVersion];
    NSArray *array = [deviceVersion componentsSeparatedByString:@"."];
    return array.firstObject;
}

+ (NSString *)iOSVersion {
    NSString *deviceVersion = [[UIDevice currentDevice] systemVersion];
    return deviceVersion;
}

+ (NSString *)getDeviceIDInKeychain {
    
    NSString *saveKey = [NSString stringWithFormat:@"%@%@", kBundleIdentifier, @"saveKey"];
    NSString *getUDIDInKeychain = (NSString *)[self load:saveKey];
    if (!getUDIDInKeychain ||[getUDIDInKeychain isEqualToString:@""]||[getUDIDInKeychain isKindOfClass:[NSNull class]]) {
        CFUUIDRef uuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString(nil,uuid);
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(uuid);
        CFRelease(uuidString);
        [self save:saveKey data:result];
        getUDIDInKeychain = (NSString *)[self load:saveKey];
    }
    
    getUDIDInKeychain = [getUDIDInKeychain stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return getUDIDInKeychain.lowercaseString;
}

/**
 获取运营商编号
 一部分叫MCC(Mobile Country Code
 移动国家码)，MCC的资源由国际电联(ITU)统一分配，唯一识别移动用户所属的国家，MCC共3位，中国地区的MCC为460

 另一部分叫MNC(Mobile Network Code 移动网络号码)，用于识别移动客户所属的移动网络运营商。MNC由二到三个十进制数组成，例如中国移动MNC为00、02、07，中国联通的MNC为01、06、09，中国电信的MNC为03、05、11

 由1、2两点可知，对于中国地区来说IMSI一般为46000(中国移动)、46001(中国联通)、46003(中国电信)等
*/
+ (NSString *)getDeviceIMSI {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
        
    if (mcc != nil && mnc != nil) {
        NSString *imsi = [NSString stringWithFormat:@"%@%@", mcc, mnc];
        return imsi;
    } else {
        return @"";
    }
}

+ (NSString *)getDeviceISOCountryCode {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
//    BOOL use = carrier.allowsVOIP;
//    NSString *name = carrier.carrierName;
    NSString *code = carrier.isoCountryCode;
    
    if (code != nil) {
        return code;
    } else {
        return @"";
    }
}

#pragma mark - private

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
        } @finally {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}
@end
