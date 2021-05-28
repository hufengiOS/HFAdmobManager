//
//  VSAdBannerLoader.h
//  HFAdmobManager
//
//  Created by hf on 2021/5/27.
//

#import <Foundation/Foundation.h>
#import "VSAdMacro.h"

NS_ASSUME_NONNULL_BEGIN

@class GADBannerView;
typedef void(^VSAdBannerLoaderCompletionHandler)(GADBannerView * _Nullable bannerView, NSError * _Nullable error);


@interface VSAdBannerLoader : NSObject

- (void)loadAdsWithUnitId:(NSString *)adUnit
              containView:(UIView * _Nullable)containView
           rootController:(UIViewController *)rootController
                placeType:(VSAdShowPlaceType)placeType
        completionHandler:(VSAdBannerLoaderCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
