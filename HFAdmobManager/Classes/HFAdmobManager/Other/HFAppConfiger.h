//
//  HFAppConfiger.h
//  AnyRead
//
//  Created by 布灵布灵 on 2019/8/25.
//  Copyright © 2019 布灵布灵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define kStatusBarHeight  [HFAppConfiger sharedConfig].statusBarHeight
#define kNavBarHeight     [HFAppConfiger sharedConfig].navBarHeight
#define kTabBarHeight     [HFAppConfiger sharedConfig].tabBarHeight
#define kHomeBarHeight    [HFAppConfiger sharedConfig].homeHeight

#define isFullScreenDevice (kHomeBarHeight > 0)

@interface HFAppConfiger : NSObject

+ (instancetype)sharedConfig;

@property (nonatomic , assign) float safeAreaBottom;

@property (nonatomic , assign) float safeAreaTop;

/**
 tabBar 高度
 */
@property (nonatomic , assign) float tabBarHeight;

/**
 导航栏高度
 */
@property (nonatomic, assign) float navBarHeight;

/**
 状态栏高度
 */
@property (nonatomic, assign) float statusBarHeight;

/**
 home indicator 高度
 */
@property (nonatomic, assign) float homeHeight;



@end

NS_ASSUME_NONNULL_END
