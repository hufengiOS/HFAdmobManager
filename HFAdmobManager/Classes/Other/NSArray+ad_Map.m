//
//  NSArray+ad_Map.m
//  AnyRead
//
//  Created by SNAKE on 2019/9/25 15:18.
//  Copyright © 2019 布灵布灵. All rights reserved.
//  
//	行行无bug，类类低耦合
//	
    

#import "NSArray+ad_Map.h"

@implementation NSArray (ad_Map)

- (NSArray*)myMap:(id(^)(id))transform {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:transform(obj)];
    }];
    return array;
}

- (NSArray*)myFilter:(BOOL(^)(id))includeElement {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (includeElement(obj)) {
            [array addObject:obj];
        }
    }];
    return array;
}


@end
