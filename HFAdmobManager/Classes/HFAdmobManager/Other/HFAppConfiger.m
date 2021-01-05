//
//  HFAppConfiger.m
//  AnyRead
//
//  Created by 布灵布灵 on 2019/8/25.
//  Copyright © 2019 布灵布灵. All rights reserved.
//

#import "HFAppConfiger.h"

@implementation HFAppConfiger

+ (instancetype)sharedConfig {
    static HFAppConfiger *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _sharedSingleton = [[super allocWithZone:NULL] init];
        [_sharedSingleton restConfig];
    });
    return _sharedSingleton;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [HFAppConfiger sharedConfig];
}

// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [HFAppConfiger sharedConfig];
}

// 防止外部调用mutableCopy
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [HFAppConfiger sharedConfig];
}

- (void)restConfig {
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets insets =  [UIApplication sharedApplication].keyWindow.safeAreaInsets;
        
        self.safeAreaTop = (insets.top == 0 ? 20 : insets.top) + 44;
        self.safeAreaBottom = insets.bottom;
        self.tabBarHeight = insets.bottom + 49;
        
        self.statusBarHeight = insets.top == 0 ? 20 : insets.top;
        
        self.navBarHeight = self.statusBarHeight + 44.f;
        // 34
        self.homeHeight = self.safeAreaBottom;
        
    }else{
        self.safeAreaTop = 64;
        self.safeAreaBottom = 0;
        self.tabBarHeight = 49;
        
        self.statusBarHeight = 20.;
        self.navBarHeight = self.statusBarHeight + 44.f;
        self.homeHeight = 0;
    }
    
    
    
}

@end
