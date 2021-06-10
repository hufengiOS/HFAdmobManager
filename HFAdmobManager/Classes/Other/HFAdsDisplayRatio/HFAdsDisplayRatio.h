//   
//   HFAdsDisplayRatio.h
//   VPNProject
//   
//   Created  by hf on 2021/1/19 10:21
//   Copyright © 2021 Snake. All rights reserved.
//			🐶
//   行行无bug 类类低耦合

   

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"


NS_ASSUME_NONNULL_BEGIN

@interface HFAdsDisplayRatioModel : NSObject

@property (nonatomic, assign) VSAdUnitType unitType;
@property (nonatomic, strong) NSString *adPlace;

@property (nonatomic, assign) NSUInteger requestNum;
@property (nonatomic, assign) NSUInteger showNum;

@end


@interface HFAdsDisplayRatio : NSObject

+ (void)addRequestWithAdPlace:(VSAdShowPlaceType)adPlace unitType:(VSAdUnitType)unitType;
+ (void)addShowWithAdPlace:(VSAdShowPlaceType)adPlace unitType:(VSAdUnitType)unitType;

@end

NS_ASSUME_NONNULL_END
