//
//  VSAdNavTemplateCell.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSAdNavTemplateCell : VSAdNavTemplateBase

//- (void)showAdsInCell:(UITableViewCell *)cell nativeAd:(GADUnifiedNativeAd *)nativeAd;
- (BOOL)showAdsInCell:(UITableViewCell *)cell nativeAd:(GADUnifiedNativeAd *)nativeAd;
+ (CGFloat)heightOfAdCell;
@end

NS_ASSUME_NONNULL_END
