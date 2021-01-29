//
//  VSSerializationData.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSSerializationData : NSObject

+ (nullable NSString*)jsonStringWithObject:(id _Nullable)object;
+ (id _Nullable)objectWithJsonString:(NSString * _Nullable)jsonString;

@end

NS_ASSUME_NONNULL_END
