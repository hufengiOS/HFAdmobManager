//
//  VSAdNavTemplateHomeBottom.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/23.
//

#import "VSAdNavTemplateBase.h"

NS_ASSUME_NONNULL_BEGIN

@class VSAdNavTemplateHomeBottom;
@protocol VSAdNavTemplateHomeBottomDelegate <NSObject>

- (void)closeAdInHomeBottomAds:(VSAdNavTemplateHomeBottom *)homeBottomAds;
@end

@interface VSAdNavTemplateHomeBottom : VSAdNavTemplateBase

- (void)showInContainView:(UIView *)containView
                 nativeAd:(GADNativeAd *)nativeAd
                 delegate:(id<VSAdNavTemplateHomeBottomDelegate, VSAdNavTemplateHomeBottomClickDelegate> _Nullable)delegate;

@end

NS_ASSUME_NONNULL_END
