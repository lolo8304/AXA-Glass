//
//  UIAlertView+LamUnique.h
//
//  Provide a mechanisum to have only one alert displayed at a time (others are discarded)
//  when the locking alert is dissmissed things go back to normal.
//  
//  Alternative : maybe a better approche is to use a toastView android like
//
//  Created by Nicolas on 27/07/11.
//  Copyright 2011 Atelier du mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView (LamUnique)

- (void) showIfNotExistingOne;//lock if it is displayed
- (void) showIfNotExistingOneWithoutLock;
- (void) showAndLock;

- (void) unlockAlerts;

@end
