//
//  NSArray+Map.h
//  AnyRead
//
//  Created by SNAKE on 2019/9/25 15:18.
//  Copyright © 2019 布灵布灵. All rights reserved.
//  
//	行行无bug，类类低耦合
//	
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ad_Map)

- (NSArray*)myMap:(id(^)(id))transform;

- (NSArray*)myFilter:(BOOL(^)(id))includeElement;


@end

NS_ASSUME_NONNULL_END
