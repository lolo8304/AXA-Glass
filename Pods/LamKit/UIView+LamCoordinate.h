//
//  UIView+LamCoordinate.h
//  LamKit
//
//  Created by Mathieu Godart on 14/11/11.
//  Copyright (c) 2011-2013 L'Atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Quick access to the view coordinates.
@interface UIView (LamCoordinate)

/// X frame origin.
@property (nonatomic, assign) CGFloat x;

/// Y frame origin.
@property (nonatomic, assign) CGFloat y;

/// Frame width.
@property (nonatomic, assign) CGFloat width;

/// Frame heigh.
@property (nonatomic, assign) CGFloat height;

/// Frame width.
@property (nonatomic, assign) CGFloat w;

/// Frame heigh.
@property (nonatomic, assign) CGFloat h;

/// X center.
@property (nonatomic, assign) CGFloat centerX;

/// Y center.
@property (nonatomic, assign) CGFloat centerY;

/// Frame size
@property (nonatomic, assign) CGSize size;

/// Frame origin
@property (nonatomic, assign) CGPoint origin;

@end
