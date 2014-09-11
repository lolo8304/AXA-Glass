//
//  UILabel+LamContentSize.h
//  LamKit
//
//  Created by Mathieu Godart on 15/06/11.
//  Copyright 2011 L'atelier du mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+LamCoordinate.h"

/// Helper to determine the size of the displayed text.
@interface UILabel (LamContentSize)

/// Calculates on how many lines the label's text spreads.
- (NSUInteger)idealLineNumber;

/// Calculates on how many lines the label's text spreads, with a limit of numberOfLines.
- (NSUInteger)idealLineNumberConstrained;

/// Calculates on how many lines the given text spreads.
/// @param aText The text for which to calculate the ideal line number.
- (NSUInteger)idealLineNumberForText:(NSString *)aText;

/// Calculates the height of the label's text, rendered with the label's font.
- (CGFloat)idealHeight;

/// Calculates the height of the label's text, rendered with the label's font,
/// but limiting to text to the max number of lines (numberOfLines).
- (CGFloat)idealHeightConstrained;

/// Calculates the height of the given text, rendered with the label's font.
/// @param aText The text for which to calculate the ideal line number.
- (CGFloat)idealHeightForText:(NSString *)aText;

/// Resizes the label to display all its text, with the current width as a constraint,
/// and limiting the text to the max number of lines (numberOfLines).
- (void)sizeHeightToFit;

/// Hides the receiver if its text is empty.
- (BOOL)checkAndHideIfEmpty;

@end