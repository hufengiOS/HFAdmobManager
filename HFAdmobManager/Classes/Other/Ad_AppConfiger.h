//
//  Ad_AppConfiger.h
//  AnyRead
//
//  Created by 布灵布灵 on 2019/8/25.
//  Copyright © 2019 布灵布灵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define HF_kStatusBarHeight  [Ad_AppConfiger sharedConfig].statusBarHeight
#define HF_kNavBarHeight     [Ad_AppConfiger sharedConfig].navBarHeight
#define HF_kHomeBarHeight    [Ad_AppConfiger sharedConfig].homeHeight

#define HF_isFullScreenDevice (HF_kHomeBarHeight > 0)

@interface Ad_AppConfiger : NSObject

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
