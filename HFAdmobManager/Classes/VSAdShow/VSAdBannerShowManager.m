//
//  VSAdBannerShowManager.m
//  HFAdmobManager
//
//  Created by hf on 2021/5/27.
//

#import "VSAdBannerShowManager.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "HFAdmobManager.h"


@interface VSAdBannerShowManager()<GADBannerViewDelegate> {
    VSAdShowPlaceType _placeType;
}

@end

@implementation VSAdBannerShowManager

+ (instancetype)shareInstance {
    static VSAdBannerShowManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VSAdBannerShowManager alloc] init];
    });
    return manager;
}

+ (BOOL)showAdWithContainView:(UIView *)containView
           rootViewController:(UIViewController *)rootViewController
                   placeType:(VSAdShowPlaceType)placeType
                  bannerView:(GADBannerView *)bannerView {
    VSAdBannerShowManager *manager = [self shareInstance];
    bannerView.rootViewController = rootViewController;
    bannerView.delegate = manager;
    manager.placeType = placeType;
    
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

#pragma mark - GADBannerViewDelegate
#pragma mark Click-Time Lifecycle Notifications
- (void)bannerViewWillPresentScreen:(nonnull GADBannerView *)bannerView {
    [[HFAdmobManager shareInstance] eventWithEventName:kHFAdmobEvent_adShow placeType:self.placeType unitId:bannerView.adUnitID];
}

- (void)bannerViewWillDismissScreen:(nonnull GADBannerView *)bannerView {
    
}

- (void)bannerViewDidDismissScreen:(nonnull GADBannerView *)bannerView {
}

@end
