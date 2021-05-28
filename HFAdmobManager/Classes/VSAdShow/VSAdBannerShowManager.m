//
//  VSAdBannerShowManager.m
//  HFAdmobManager
//
//  Created by hf on 2021/5/27.
//

#import "VSAdBannerShowManager.h"
#import <GoogleMobileAds/GoogleMobileAds.h>


@interface VSAdBannerShowManager() {
    
}
@end

@implementation VSAdBannerShowManager

+ (BOOL)showAdWithContainView:(UIView *)containView
                   placeType:(VSAdShowPlaceType)placeType
                  bannerView:(GADBannerView *)bannerView {
    
    [containView addSubview:(UIView *)bannerView];
    
    [containView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:containView
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:containView
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:containView
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:containView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0],
                                    ]];
    
    return YES;
}

@end
