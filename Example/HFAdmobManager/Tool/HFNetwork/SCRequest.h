//
//  SCRequest.h
//  SmartCleaner
//
//  Created by hf on 2021/1/28.
//

#import <Foundation/Foundation.h>
#import "HFNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCRequest : NSObject

+ (instancetype)shareInstance;
+ (void)requestGlobalConfigWithCallBackHandler:(CallBackHandler)callBackHandler;

@end

NS_ASSUME_NONNULL_END
