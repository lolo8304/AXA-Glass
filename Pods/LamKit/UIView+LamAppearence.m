//
//  UIView+LamAppearence.m
//  Lamkit
//
//  Created by Mathieu Godart on 30/05/11.
//  Copyright 2011 L'atelier du mobile. All rights reserved.
//

#import "UIView+LamAppearence.h"
#import <QuartzCore/QuartzCore.h>



@implementation UIView (LamAppearence)



// Generate an image of the receiver appearance.
// TODO: Improve the target resolution of the generated photo. See that page, to do so:
// http://stackoverflow.com/questions/2500915/how-to-create-an-image-from-a-uiview-uiscrollview
- (UIImage *)generateImage
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef generatingContext = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:generatingContext];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



// Returns the surface of the view.
- (CGFloat)surface
{
	return self.frame.size.width * self.frame.size.height;
}



// Round the corners of the view.
- (void)roundCornerWithRadius:(CGFloat)aRadius
{
    self.layer.cornerRadius = aRadius;
}



// Add a border to the view.
- (void)addBorderWithColor:(UIColor *)aColor width:(CGFloat)aWidth
{
    self.layer.borderColor = aColor.CGColor;
    self.layer.borderWidth = aWidth;
}



// Add a shadow to the view.
- (void)addShadowWithOpacity:(CGFloat)anOpacity blur:(CGFloat)aBlurRadius offset:(CGSize)anOffset
{
    self.layer.shadowOpacity = anOpacity;
    self.layer.shadowRadius = aBlurRadius;
    self.layer.shadowOffset = anOffset;
}



// Make a view dance.
- (void)wiggleViewWithIntensity:(CGFloat)intensity andDuration:(CGFloat)duration
{
    CALayer *touchedLayer = [self layer];
    CABasicAnimation *wiggleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    wiggleAnimation.duration = duration;
    wiggleAnimation.repeatCount = MAXFLOAT;
    wiggleAnimation.autoreverses = YES;
    wiggleAnimation.fromValue = [NSValue valueWithCATransform3D:
                                 CATransform3DRotate(touchedLayer.transform, intensity, 0.0, 0.0, 1.0)];
    wiggleAnimation.toValue = [NSValue valueWithCATransform3D:
                               CATransform3DRotate(touchedLayer.transform, 0, 0.0, 0.0, 1.0)];
    [touchedLayer addAnimation:wiggleAnimation forKey:@"wiggle"];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = duration;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.autoreverses = YES;
    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(touchedLayer.position.x,
                                                                    touchedLayer.position.y)];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(touchedLayer.position.x,
                                                                  touchedLayer.position.y + 4)];
    [touchedLayer addAnimation:moveAnimation forKey:@"move"];
    
}



/// Apply the given font to all subviews, but keeps the subview's current font size.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName
{
	//    // Recursive call to all subviews.
	//    for (UIView *aView in self.subviews) {
	//        [aView setFontForAllSubviewsWithName:aFontName];
	//    }
	//
	//    // Do it to myself.
	//    if ([self respondsToSelector:@selector(setFont:)] &&
	//        [self respondsToSelector:@selector(font)]) {
	//
	//        UIFont *myFont = [(id)self font];
	//        [(id)self setFont:[UIFont fontWithName:aFontName size:[myFont pointSize]]];
	//    }
    
    [self setFontForAllSubviewsWithName:aFontName boldFontName:nil];
}



/// Apply the given font to all subviews, but keeps the subview's current font size.
/// If the original font was bold, boldFontName is used instead.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName
                         boldFontName:(NSString *)aBoldFontName
{
    // Recursive call to all subviews.
    for (UIView *aView in self.subviews) {
        [aView setFontForAllSubviewsWithName:aFontName
                                boldFontName:aBoldFontName];
    }
	
    // Do it to myself.
    if ([self respondsToSelector:@selector(setFont:)] &&
        [self respondsToSelector:@selector(font)]) {
        
        UIFont *myFont = [(id)self font];
        NSString *myFontName = [myFont fontName];
		
        // Check if the font is bold and if a bold font has been provided.
        BOOL isBlod = NO;
        if (aBoldFontName != nil) isBlod = isABoldFontName(myFontName);
		
        UIFont *newFont;
        if (isBlod) newFont = [UIFont fontWithName:aBoldFontName size:[myFont pointSize]];
        else newFont = [UIFont fontWithName:aFontName size:[myFont pointSize]];
        
        [(id)self setFont:newFont];
    }
}

/// Apply the given font to all subviews, but keeps the subview's current font size.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName andSize:(CGFloat)fontSize
{
	//    // Recursive call to all subviews.
	//    for (UIView *aView in self.subviews) {
	//        [aView setFontForAllSubviewsWithName:aFontName];
	//    }
	//
	//    // Do it to myself.
	//    if ([self respondsToSelector:@selector(setFont:)] &&
	//        [self respondsToSelector:@selector(font)]) {
	//
	//        UIFont *myFont = [(id)self font];
	//        [(id)self setFont:[UIFont fontWithName:aFontName size:[myFont pointSize]]];
	//    }
    
    [self setFontForAllSubviewsWithName:aFontName boldFontName:nil andSize:fontSize];
}



/// Apply the given font to all subviews, but keeps the subview's current font size.
/// If the original font was bold, boldFontName is used instead.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName
                         boldFontName:(NSString *)aBoldFontName
							  andSize:(CGFloat)fontSize
{
    // Recursive call to all subviews.
    for (UIView *aView in self.subviews) {
        [aView setFontForAllSubviewsWithName:aFontName
                                boldFontName:aBoldFontName];
    }
	
    // Do it to myself.
    if ([self respondsToSelector:@selector(setFont:)] &&
        [self respondsToSelector:@selector(font)]) {
        
        UIFont *myFont = [(id)self font];
        NSString *myFontName = [myFont fontName];
		
        // Check if the font is bold and if a bold font has been provided.
        BOOL isBlod = NO;
        if (aBoldFontName != nil) isBlod = isABoldFontName(myFontName);
		
        UIFont *newFont;
        if (isBlod) newFont = [UIFont fontWithName:aBoldFontName size:fontSize];
        else newFont = [UIFont fontWithName:aFontName size:fontSize];
        
        [(id)self setFont:newFont];
    }
}

BOOL isABoldFontName(NSString *fontName)
{
    if ([fontName rangeOfString:@"bold" options:NSCaseInsensitiveSearch].location != NSNotFound &&
        fontName != nil)
    {
        return YES;
    }
    return NO;
}



@end






















