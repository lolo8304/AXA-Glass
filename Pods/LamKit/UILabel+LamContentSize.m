//
//  UILabel+LamContentSize.m
//  EurActiv
//
//  Created by Mathieu Godart on 15/06/11.
//  Copyright 2011 L'atelier du mobile. All rights reserved.
//

#import "UILabel+LamContentSize.h"


@implementation UILabel (LamContentSize)



// Calculates on how many lines the label's text spreads.
- (NSUInteger)idealLineNumber {
    
    return [self idealLineNumberForText:self.text];
}



// Calculates on how many lines the label's text spreads, with a limit of numberOfLines.
- (NSUInteger)idealLineNumberConstrained {
    
    return MIN([self idealLineNumber], self.numberOfLines);
}



// Calculates on how many lines the given text spreads.
- (NSUInteger)idealLineNumberForText:(NSString *)aText {
    
    return [self idealHeightForText:aText] / [self.font lineHeight];
}



- (CGFloat)idealHeight {
    
    return [self idealHeightForText:self.text];
}



- (CGFloat)idealHeightConstrained {
    
    return MIN([self idealHeightForText:self.text],
               [self numberOfLines] * [self.font lineHeight]);
}




- (CGFloat)idealHeightForText:(NSString *)aText {
    
    // Do not give a height limit, as we want to know the height limit.
    CGSize constraintSize = CGSizeMake(self.frame.size.width, INT32_MAX);
    
    // iOS 7 deprecation.
#if __IPHONE_OS_VERSION_MIN_REQUIRED <= __IPHONE_7_0
    CGRect rect = [aText boundingRectWithSize:constraintSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:nil context:nil];
    CGSize size = rect.size;
#else
    CGSize size = [aText sizeWithFont:self.font constrainedToSize:constraintSize];
#endif

    return ceil(size.height);
}



- (void)sizeHeightToFit {
    
    self.height = [self idealHeightConstrained];
}



// Hides the receiver if its text is empty.
- (BOOL)checkAndHideIfEmpty {
    
    if (self.text == nil || [self.text isEqualToString:@""]) {
        
        self.hidden = YES;
        return YES;
    }
    else {
        
        self.hidden = NO;
        return NO;
    }
}



@end
