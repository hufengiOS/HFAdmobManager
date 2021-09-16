//
//  HFNetwork.m
//  SmartCleaner
//
//  Created by hf on 2021/1/6.
//

#import "HFNetwork.h"
#import "AFHTTPSessionManager.h"
#import "HFNetwork.h"
#import <GZIP.h>
#import <MJExtension/MJExtension.h>
#import "AESTool.h"
#import "VSSerializationData.h"


/// 和后台交互的加密操作
NSString *const kAPIEncryptInitVector = @"G@5HniRroQZ4Udt#";
NSString *const kAPIEncryptKey = @"TLqM@@FsfAeW*54x";

/// 和后台交互的解密操作
NSString *const kAPIDecryptInitVector = @"Qg$UDAL&k&vHP61C";
NSString *const kAPIDecryptKey = @"EspBeKf%o#Ls038D";


@interface HFNetwork ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HFNetwork

+ (instancetype)shareInstance {
    static HFNetwork *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[HFNetwork alloc] init];
        _shareInstance.manager = [AFHTTPSessionManager manager];
        _shareInstance.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self notificationNetwork];
    });
    return _shareInstance;
}

+ (void)postEncodeDataWithUrlPath:(NSString *)urlPath
                           method:(HTTPMethodType)type
                           params:(nullable NSDictionary *)params
                  callBackHandelr:(CallBackHandler)callbackHandler {
    
    //dict转jsonstring
    NSString *jsonString = [params mj_JSONString];
    jsonString = [self aesPostWithDict:params];
    
    NSData *encodeData = [AESTool encryptAES:jsonString key:kAPIEncryptKey vector:kAPIEncryptInitVector];
    NSData *gZipData = [encodeData gzippedData];
    
    [self requestBaseWithUrl:urlPath
                      method:HTTPMethodTypeGET == type ? @"GET":@"POST"
                        body:gZipData
             timeoutInterval:10
             callBackHandler:^(NSDictionary *  _Nullable dataModel, NSError * _Nullable error) {
        if (dataModel) {
            NSData *ugZipData = [(NSData *)dataModel gunzippedData];
            NSData *respondData = [AESTool decryptAES:ugZipData key:kAPIDecryptKey vector:kAPIDecryptInitVector];
            
            //解密
            NSString *str = [[NSString alloc] initWithData:respondData encoding:NSUTF8StringEncoding];
            [self logInfoWithUrl:urlPath param:params response:[VSSerializationData objectWithJsonString:str] error:nil];
            !callbackHandler ? : callbackHandler([VSSerializationData objectWithJsonString:str], nil);
        } else {
            !callbackHandler ? : callbackHandler(nil, error);
        }
    }];
    
}

#pragma mark - 其他接口
+ (void)postCommonWithUrlPath:(NSString *)urlPath
                       method:(HTTPMethodType)type
                       params:(nullable NSDictionary *)params
              callBackHandler:(CallBackHandler)callBackHandler {
    NSString *jsonString = [params mj_JSONString];
    NSData *jsonData = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
    [self requestBaseWithUrl:urlPath
                      method:HTTPMethodTypeGET == type ? @"GET":@"POST"
                        body:jsonData
             timeoutInterval:10
             callBackHandler:^(id _Nullable dataModel, NSError * _Nullable error) {
        if (dataModel) {
            NSString *response = [[NSString alloc] initWithData:dataModel encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [VSSerializationData objectWithJsonString:response];
            [self logInfoWithUrl:urlPath param:params response:dic error:nil];
            !callBackHandler ? : callBackHandler(dic, nil);
        } else {
            [self logInfoWithUrl:urlPath param:params response:nil error:error];
            !callBackHandler ? : callBackHandler(nil, error);
        }
    }];
}

+ (void)requestBaseWithUrl:(NSString *)url
                    method:(NSString *)method
                      body:(NSData *)postData
           timeoutInterval:(NSTimeInterval)timeoutInterval
           callBackHandler:(CallBackHandler)callBackHandler {
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:timeoutInterval];
    [request setHTTPMethod:method];
    [request setHTTPBody:postData];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
#ifdef DEBUG
    [request setValue:kdomainStr forHTTPHeaderField:@"domain"];
#endif
    
    NSURLSessionDataTask *task = [[HFNetwork shareInstance].manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        !callBackHandler ? : callBackHandler(responseObject, error);
    }];
    [task resume];
}

+ (void)notificationNetwork {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                [[NSNotificationCenter defaultCenter] postNotificationName:VPNotificationNameNetworkStatus object:@NO];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [[NSNotificationCenter defaultCenter] postNotificationName:VPNotificationNameNetworkStatus object:@YES];
                break;
            default:
                break;
        }
    }];
}

+ (NSString *)aesPostWithDict:(NSDictionary *)dict {
    
    NSString *jsonString = [NSString stringWithFormat:@"%@%@", kBuildIdentifyStr, [dict mj_JSONString]];
    NSData *testData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];//字符串转化成 data
    char *dataByte = (char *)[testData bytes];
    NSInteger len = testData.length + 1;
    char *newByte = malloc(sizeof(char)*(len));
    newByte[0] = kBuildIdentifyStr.length; //增加签名长度
    for (int i = 1; i <= [testData length]; i++)
    {
        newByte[i] = dataByte[i - 1];
    }
    //byte-->data-->string
    NSData *adata = [[NSData alloc] initWithBytes:newByte length:len];
    NSString *result = [[NSString alloc] initWithData:adata encoding:NSUTF8StringEncoding];
    
    free(newByte);
    return result;
}

+ (void)logInfoWithUrl:(NSString *)url param:(NSDictionary *)param response:(id)response error:(NSError *)error {
    NSString *message = [NSString stringWithFormat:@"\n----------- %@ ----------\n \t参数：\n%@ \n\t结果：\n%@\n \t错误：\n%@\n", url, [VSSerializationData jsonStringWithObject:param], [VSSerializationData jsonStringWithObject:response], error];
    NSLog(@"%@", message);
}

@end
