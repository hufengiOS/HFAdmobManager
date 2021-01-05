//
//  UIView+Extension.m
//  ChainHoo
//
//  Created by SNAKE on 2018/3/12.
//  Copyright © 2018年 hufeng. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect newframe = self.frame;
    newframe.origin.x = right - self.frame.size.width;
    self.frame = newframe;
}

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(CGPoint)origin
{
    return self.frame.origin;
}

- (void)removeAllSubViews
{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}


//给view上下左右某个遍加分割线
#pragma color 颜色  borderWidth 分割线高 position分割线位置 可或
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position {
    
    if (position & PositionTOP){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    }
    
    if (position & PositionBOTTOM){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, borderWidth);
    }
    if (position & PositionLEFT){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    }
    
    if (position & PositionRIGHT) {
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    }
}

- (CALayer*)createCALayerWithColor: (UIColor *) color {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    [self.layer addSublayer:border];
    return border;
}

- (void)cornerRadius:(CGFloat)radius roundingCorners:(UIRectCorner)roundingCorners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(radius,radius)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

- (void)cornerRadius:(CGFloat)radius {
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
//    //创建 layer
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.bounds;
//    //赋值
//    maskLayer.path = maskPath.CGPath;
//    self.layer.mask = maskLayer;
    [self cornerRadius:radius borderWidth:0 borderColor:nil];
}

- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    //路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    
    //赋值
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
    
    if (borderWidth > 0) {
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.frame = self.bounds;
        borderLayer.lineWidth = borderWidth;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.path = path.CGPath;
        [self.layer addSublayer:borderLayer];
    }
}

- (void)hf_shadowColor:(UIColor *)shadowColor
       shadowOffset:(CGSize)shadowOffset
       shadowRadius:(CGFloat)shadowRadius
      shadowOpacity:(CGFloat)shadowOpacity
         andPostion:(Position)position {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = shadowOpacity;
    
    self.clipsToBounds = NO;
    
    CGFloat edgeHeight = 1;
    if (position & PositionTOP){
        [path moveToPoint:CGPointMake(0, edgeHeight)];
        [path addLineToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.width, 0)];
        [path addLineToPoint:CGPointMake(self.width, edgeHeight)];
    }
    
    if (position & PositionBOTTOM){
        [path moveToPoint:CGPointMake(0, self.height - edgeHeight)];
        [path addLineToPoint:CGPointMake(0, self.height)];
        [path addLineToPoint:CGPointMake(self.width, self.height)];
        [path addLineToPoint:CGPointMake(self.width, self.height - edgeHeight)];
    }
    
    if (position & PositionLEFT){
        [path moveToPoint:CGPointMake(edgeHeight, 0)];
        [path addLineToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(0, self.height)];
        [path addLineToPoint:CGPointMake(edgeHeight, self.height)];
    }

    if (position & PositionRIGHT) {
        [path moveToPoint:CGPointMake(self.width - edgeHeight, 0)];
        [path addLineToPoint:CGPointMake(self.width, 0)];
        [path addLineToPoint:CGPointMake(self.width, self.height)];
        [path addLineToPoint:CGPointMake(self.width - edgeHeight, self.height)];
    }
    self.layer.shadowPath = path.CGPath;
}

- (void)hf_shadowColor:(UIColor *)shadowColor
       shadowOffset:(CGSize)shadowOffset
       shadowRadius:(CGFloat)shadowRadius
      shadowOpacity:(CGFloat)shadowOpacity {
    [self hf_shadowColor:shadowColor shadowOffset:shadowOffset shadowRadius:shadowRadius shadowOpacity:shadowOpacity andPostion:PositionALL];
}

- (void)shadowCornerRadius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    self.layer.shadowPath = maskPath.CGPath;
    self.layer.shadowColor = [UIColor blueColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1.0;
    
    self.clipsToBounds = NO;
    
}


/**
 获取当前视图所在的控制器

 @return return value description
 */
- (UIViewController *)parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}

- (void)hf_addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGesture];
}

@end
