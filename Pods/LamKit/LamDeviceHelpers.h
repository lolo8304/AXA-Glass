//
//  LamDeviceHelpers.h
//
//  Created by Mathieu Godart on 04/10/11.
//  Copyright 2011 L'atelier du mobile. All rights reserved.
//



/// iOS version check.
#define isRunningOniOS6() (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
#define isSystemVersionIOS7()						SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")


/// Returns `YES` if the device on which this code is executed is an iPad.
#define isRunningOniPad()   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isRunningOniPhone() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)



/// Returns `YES` if the device has got a retina screen
#define isRunningOnRetinaScreen() ([UIScreen mainScreen].scale == 2.0)



/// Returns `YES` if the device has got a retina screen
#define isRunningOnFourInchesScreen() (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)



/// Returns `YES` if the device has a camera available.
#define deviceHasCamera() \
([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])

#define deviceHasPhotoLibrary() \
([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])



/// Gives the current country code or localized country name of the iDevice.
#define deviceCurrentCountryCode() \
((NSString *)[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode])

#define deviceCurrentCountryLocalized() \
[[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:deviceCurrentCountryCode()]

#define deviceCurrentLanguageCode() \
((NSString *)[[NSLocale preferredLanguages] objectAtIndex:0])



/// Quick access to the user defaults.
#define getUserDefaultsBoolForKey(K)      [[NSUserDefaults standardUserDefaults] boolForKey:K]
#define getUserDefaultsObjectForKey(K)    [[NSUserDefaults standardUserDefaults] objectForKey:K]
#define setUserDefaultsBoolForKey(B, K)   [[NSUserDefaults standardUserDefaults] setBool:B forKey:K]
#define setUserDefaultsObjectForKey(O, K) [[NSUserDefaults standardUserDefaults] setObject:O forKey:K]
#define syncUserDefaults()                [[NSUserDefaults standardUserDefaults] synchronize]

// Misc constants.
#define kStatusBarHeight 20
///@deprecated
///keyboard Size (for not waiting Notification of Keyboard to get the size)
#define kKeyboardHeightPortrait  264.0f
#define kKeyboardHeightLandscape 352.0f

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



// This is what you should show to your user.
#define getAppVersion() [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// This is the developper version.
#define getAppCodeVersion()  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define getDeviceOSVersion() [[UIDevice currentDevice] systemVersion]
#define getDeviceModel()     [[UIDevice currentDevice] model]




