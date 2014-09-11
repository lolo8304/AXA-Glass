//
//  UIView+LamAppearence.h
//  LamKit
//
//  Created by Mathieu Godart on 30/05/11.
//  Copyright 2011 L'atelier du mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/// Modification of the view's appearance.
@interface UIView (LamAppearence)

/// Generate an image of the receiver appearance.
- (UIImage *)generateImage;

/// Returns the surface of the view.
- (CGFloat)surface;

/// Round the corners of the view.
/// @param aRadius Roundness of the view's corner.
- (void)roundCornerWithRadius:(CGFloat)aRadius;

/// Add a border to the view.
/// @param aColor Color of the border.
/// @param aWidth Width of the border.
- (void)addBorderWithColor:(UIColor *)aColor width:(CGFloat)aWidth;

/// Add a shadow to the view.
/// Reasonable values would be:
///     [self.searchTxtFieldView addShadowWithOpacity:0.5 blur:3 offset:CGSizeMake(0, -3)];
- (void)addShadowWithOpacity:(CGFloat)anOpacity blur:(CGFloat)aBlurRadius offset:(CGSize)anOffset;

/// Animate a view to make it dance.
/// @todo Move this somewhere else.
/// @param intensity Intensity of the dance.
/// @param duration Duration of the dance. At the end of this duration, the dance stops.
- (void)wiggleViewWithIntensity:(CGFloat)intensity andDuration:(CGFloat)duration;

/// Apply the given font to all subviews, but keeps the subview's current font size.
/// @param aFontName The name of the font to apply to all subviews.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName;

/// Apply the given font to all subviews, but keeps the subview's current font size.
/// If the original font was bold, boldFontName is used instead.
/// @param aFontName The name of the font to apply to all subviews.
/// @param aBoldFontName The name of the font to apply to all subviews, when the original font is bold.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName
                         boldFontName:(NSString *)aBoldFontName;

/// Apply the given font to all subviews, and set the subview's new font size.
/// @param aFontName The name of the font to apply to all subviews.
/// @param fontSize The size of the font to apply to all subviews.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName
							  andSize:(CGFloat)fontSize;

/// Apply the given font to all subviews, and set the subview's new font size.
/// If the original font was bold, boldFontName is used instead.
/// @param aFontName The name of the font to apply to all subviews.
/// @param aBoldFontName The name of the font to apply to all subviews, when the original font is bold.
/// @param fontSize The size of the font to apply to all subviews.
- (void)setFontForAllSubviewsWithName:(NSString *)aFontName
                         boldFontName:(NSString *)aBoldFontName
							  andSize:(CGFloat)fontSize;

@end
