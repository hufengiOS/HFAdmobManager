//
//  SCRequest.m
//  SmartCleaner
//
//  Created by hf on 2021/1/28.
//

#import "SCRequest.h"
#import "HFNetwork.h"
#import "HFDeviceInfo.h"

#ifdef DEBUG
static NSString *kBuildIdentifyStr = @"com.yt.smartCleaner_debug";
#else
static NSString *kBuildIdentifyStr = @"com.yt.smartCleaner";
#endif


static NSString *kVPNServerPath = @"http://api.securevpn.club";



#define ServerPath(s) [kVPNServerPath stringByAppendingPathComponent:(s)]


@implementation SCRequest

+ (instancetype)shareInstance {
    static SCRequest *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SCRequest alloc] init];
    });
    return manager;
}

#pragma mark - private
+ (NSMutableDictionary *)commonParamWithDic:(NSDictionary *)dic {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    
    [params setValue:[HFDeviceInfo getDeviceIDInKeychain] forKey:@"aid"];
    
    [params setValue:kBuildIdentifyStr forKey:@"pkg"];

    // ios 版本号
    [params setValue:[HFDeviceInfo getSdkVersion] forKey:@"sdk"];
    // app版本号
    [params setValue:[HFDeviceInfo getAPIVersion] forKey:@"ver"];
    
    // 客户端实际所在的国家，没获取到为空
//    [params setValue:[self currentDeviceLocation] forKey:@"country"];
    // VPN是否已链接
    // 当前手机使用的语言
    [params setValue:@"EN" forKey:@"lang"];
    
    [params setValue:[HFDeviceInfo getDeviceIMSI] forKey:@"plmn"];
    [params setValue:[HFDeviceInfo getDeviceISOCountryCode] forKey:@"simCountryIos"];
    [params setValue:@([[NSDate date] timeIntervalSince1970]) forKey:@"currentTime"];
    return params;
}

#pragma mark - public
+ (void)requestGlobalConfigWithCallBackHandler:(CallBackHandler)callBackHandler {
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    param = [self commonParamWithDic:param];
    [HFNetwork postEncodeDataWithUrlPath:ServerPath(@"conf")
                                  method:HTTPMethodTypePOST
                                  params:param
                         callBackHandelr:callBackHandler];
}
@end
