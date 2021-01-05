//
//  UIView+Extension.h
//  ChainHoo
//
//  Created by SNAKE on 2018/3/12.
//  Copyright © 2018年 hufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS ( NSUInteger, Position){
    PositionTOP      = 1 << 0,
    PositionLEFT     = 1 << 1,
    PositionBOTTOM   = 1 << 2,
    PositionRIGHT    = 1 << 3,
    PositionALL      = ~0UL
};

@interface UIView (Extension)


@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;


- (void)removeAllSubViews;

//** 给view上下左右某个遍加分割线
#pragma color 颜色  borderWidth 分割线高 position分割线位置 可或
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position;
//圆角
- (void)cornerRadius:(CGFloat)radius roundingCorners:(UIRectCorner)roundingCorners;
- (void)cornerRadius:(CGFloat)radius;
- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


- (void)hf_shadowColor:(UIColor *)shadowColor
       shadowOffset:(CGSize)shadowOffset
       shadowRadius:(CGFloat)shadowRadius
      shadowOpacity:(CGFloat)shadowOpacity
         andPostion:(Position)position;

- (void)hf_shadowColor:(UIColor *)shadowColor
       shadowOffset:(CGSize)shadowOffset
       shadowRadius:(CGFloat)shadowRadius
      shadowOpacity:(CGFloat)shadowOpacity ;


- (UIViewController *)parentController;


- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;

- (void)hf_addTarget:(id)target action:(SEL)action;
@end
