//
//  VSAdNavTemplateCell.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSAdNavTemplateCell : VSAdNavTemplateBase

- (BOOL)showAdsInCell:(UITableViewCell *)cell nativeAd:(GADNativeAd *)nativeAd;
+ (CGFloat)heightOfAdCell;
@end

NS_ASSUME_NONNULL_END
