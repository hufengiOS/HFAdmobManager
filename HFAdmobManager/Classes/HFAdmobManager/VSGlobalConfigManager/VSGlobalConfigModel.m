//
//  VSGlobalConfigModel.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/17.
//

#import "VSGlobalConfigModel.h"
#import "VSAdMacro.h"
@implementation VSGlobalConfigModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"adCfgs":[VSGlobalConfigAdsConfigModel class]};
}

@end

@implementation VSGlobalConfigAdsConfigModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"adSources": [VSGlobalConfigAdsConfigAdPlaceModel class]};
}

- (VSAdShowPlaceType)adNameType {
    NSDictionary *dic = [self dicNameKey];
    if ([dic.allKeys containsObject:self.adName.uppercaseString]) {
        return [dic[self.adName.uppercaseString] intValue];
    }
    return VSAdShowPlaceTypeUnknown;
}

- (NSDictionary *)dicNameKey {
    return @{@"AD_HOME": @(VSAdShowPlaceTypePartHome),
             @"AD_STATUS": @(VSAdShowPlaceTypePartOther),
             @"AD_START": @(VSAdShowPlaceTypeFullStart),
             @"AD_CONNECT": @(VSAdShowPlaceTypeFullConnect),
             @"AD_EXTRA": @(VSAdShowPlaceTypeFullExtra)};
}

@end

@implementation VSGlobalConfigCloseBtnModel
@end

@implementation VSGlobalConfigAdsConfigAdPlaceModel
- (VSAdUnitType)adUnitType {
    if ([self.adFormatType isEqualToString:@"nav"]) {
        return VSAdUnitTypeNav;
    } else if ([self.adFormatType isEqualToString:@"int"]) {
        return VSAdUnitTypeInt;
    } else {
        return VSAdUnitTypeUnknown;
    }
}
@end

@implementation VSGlobalConfigPayItemModel
@end

@implementation VSGlobalConfigPayModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"itemList": [VSGlobalConfigPayItemModel class]};
}

- (NSArray<NSString *> *)itemProductIdArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self.itemList enumerateObjectsUsingBlock:^(VSGlobalConfigPayItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:obj.productId];
    }];
    return array;
}
@end

@implementation VSGlobalConfigVersionModel
@end
