//
//  VSSerializationData.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import "VSSerializationData.h"

@implementation VSSerializationData

+ (nullable NSString*)jsonStringWithObject:(id _Nullable)object {
    if (!object) {
        return nil;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (id _Nullable)objectWithJsonString:(NSString * _Nullable)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    
    if(err) {/*JSON解析失败*/
        return nil;
    }
    return dic;
}

@end
