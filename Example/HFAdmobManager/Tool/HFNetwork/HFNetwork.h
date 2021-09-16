//
//  HFNetwork.h
//  SmartCleaner
//
//  Created by hf on 2021/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *kBuildIdentifyStr = @"com.sk.vpm.m208vpm";
static NSString *kdomainStr = @"api.soloproxy.xyz";
static NSString *kVPNServerPath = @"http://47.106.226.233:11000";


static NSString *const VPNotificationNameNetworkStatus = @"VPNotificationNameNetworkStatus";
typedef NS_ENUM(NSUInteger, HTTPMethodType) {
    HTTPMethodTypeGET,
    HTTPMethodTypePOST
};


// 网络请求结果
typedef void(^CallBackHandler)(NSDictionary * _Nullable dataModel , NSError * _Nullable error);

@interface HFNetwork : NSObject


+ (void)postEncodeDataWithUrlPath:(NSString *)urlPath
                           method:(HTTPMethodType)type
                           params:(nullable NSDictionary *)params
                  callBackHandelr:(CallBackHandler)callbackHandler;

#pragma mark - 其他接口
+ (void)postCommonWithUrlPath:(NSString *)urlPath
                       method:(HTTPMethodType)type
                       params:(nullable NSDictionary *)params
              callBackHandler:(CallBackHandler)callBackHandler;

@end

NS_ASSUME_NONNULL_END
