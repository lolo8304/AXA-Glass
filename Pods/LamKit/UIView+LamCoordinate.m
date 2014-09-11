//
//  UIView+Coordinate.m
//  LamKit
//
//  Created by Mathieu Godart on 14/11/11.
//  Copyright (c) 2011 L'atelier du mobile. All rights reserved.
//

#import "UIView+LamCoordinate.h"

@implementation UIView (LamCoordinate)

- (CGFloat) height {
    return self.bounds.size.height;
}

- (CGFloat) h {
    return self.height;
}

- (CGFloat) width {
    return self.bounds.size.width;
}

- (CGFloat) w {
    return self.width;
}

- (CGFloat) x {
    return self.frame.origin.x;
}

- (CGFloat) y {
    return self.frame.origin.y;
}

- (CGFloat) centerX {
    return self.center.x;
}

- (CGFloat) centerY {
    return self.center.y;
}

- (CGSize)size {
	return self.frame.size;
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void) setHeight:(CGFloat) newHeight {
    CGRect bounds = self.bounds;
    bounds.size.height = newHeight;
    self.bounds = bounds;
}

- (void) setH:(CGFloat) newHeight {
    self.height = newHeight;
}

- (void) setWidth:(CGFloat) newWidth {
    CGRect bounds = self.bounds;
    bounds.size.width = newWidth;
    self.bounds = bounds;
}

- (void) setW:(CGFloat) newWidth {
    self.width = newWidth;
}

- (void) setX:(CGFloat) newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (void) setY:(CGFloat) newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (void) setCenterX:(CGFloat) newCenterX {
    CGPoint center = self.center;
    center.x = newCenterX;
    self.center = center;
}

- (void) setCenterY:(CGFloat) newCenterY {
    CGPoint center = self.center;
    center.y = newCenterY;
    self.center = center;
}

- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

@end
