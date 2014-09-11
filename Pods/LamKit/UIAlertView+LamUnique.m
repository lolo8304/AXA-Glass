//
//  UIAlertView+LamUnique.m
//
//  Created by Nicolas on 27/07/11.
//  Copyright 2011 Atelier du mobile. All rights reserved.
//

#import "UIAlertView+LamUnique.h"
#import <objc/runtime.h>

static bool hasCurrentAlertDisplayed;

@implementation UIAlertView (LamUnique)


- (void) unlockAlerts {
    hasCurrentAlertDisplayed = FALSE;
    //LoggerAlert(5,@"hasCurrentAlertDisplayed=%d", hasCurrentAlertDisplayed);
}

//we can display an alert if :
// - the app is active
// - an alert is not currently displayed

- (BOOL) isAlertDisplayable {
    //LoggerAlert(5,@"hasCurrentAlertDisplayed=%d", hasCurrentAlertDisplayed);

    if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive
       && !hasCurrentAlertDisplayed ) {
        
        return TRUE;
    }
    return FALSE;
}


- (void)showAndLock {
    hasCurrentAlertDisplayed = TRUE;
    //LoggerAlert(5,@"set hasCurrentAlertDisplayed %d", hasCurrentAlertDisplayed);
    
    [self show];
}

    
- (void)showIfNotExistingOne {
    
    if ([self isAlertDisplayable]) {
        hasCurrentAlertDisplayed = TRUE;
        //LoggerAlert(5,@"set hasCurrentAlertDisplayed %d", hasCurrentAlertDisplayed);
        
        [self show];
    }
}

- (void)showIfNotExistingOneWithoutLock {
    
    if ([self isAlertDisplayable]) {
        hasCurrentAlertDisplayed = TRUE;
        //LoggerAlert(5,@"set hasCurrentAlertDisplayed %d", hasCurrentAlertDisplayed);
        
        [self show];
    }
}

@end
