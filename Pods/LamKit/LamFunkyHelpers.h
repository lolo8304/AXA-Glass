//
//  LamFunkyHelpers.h
//  LamKit
//
//  Created by Mathieu Godart on 05/10/11.
//  Copyright (c) 2011-2013 L'Atelier du mobile. All rights reserved.
//

#import <objc/runtime.h>



/// Stringification, see this:
/// http://gcc.gnu.org/onlinedocs/cpp/Stringification.html
#define xstr(s) str(s)
#define str(s) #s



/// Processes the given formatted NSString.
#define StrF StrFmt
#define StrFmt(x, ...) [NSString stringWithFormat:(x), ##__VA_ARGS__]
/// Localizes the given NSString, filename as a comment.
#define StrL StrLoc
#define StrLoc(x, cmt) NSLocalizedString((x), (cmt))



/// LOG_EXPR helper.
#ifdef DEBUG
#    define L(x) LOG_EXPR(x)
#else
#    define L(x) while(0) {}
#endif



/// Returns NO is the object is nil or empty.
/// http://www.wilshipley.com/blog/2005/10/pimp-my-code-interlude-free-code.html
static inline BOOL IsEmpty(id thing)
{
	return thing == nil || thing == NSNull.null ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

static inline BOOL IsNotEmpty(id thing)
{
    return IsEmpty(thing) == NO;
}


// Returns YES is the obects are equal or if both are nil.
static inline BOOL AreEqualOrNil(id obj1, id obj2)
{
    return ([obj1 isEqual:obj2] ||
            (obj1 == nil && obj2 == nil));
}



/// Checks if it is possible to get an object at this index, then returns it.
/// Else, returns nil (out of bounds, or does not answer to count or objectAtIndex:).
static inline id safeObjectAtIndex(id aCollection, NSUInteger index)
{
    if (![aCollection respondsToSelector:@selector(objectAtIndex:)]) return nil;
    if (![aCollection respondsToSelector:@selector(count)]) return nil;
    if (index >= [aCollection count]) return nil;
    
    return [aCollection objectAtIndex:index];
}



/// Returns an empty string if the given object is nil or is not a string.
/// Also works for NSNumbers.
static inline NSString *emptyStringIfNil(id object)
{
    if ([object isKindOfClass:[NSString class]]) return object;
    if ([object isKindOfClass:[NSNumber class]]) return StrFmt(@"%@", object);
    return @"";
}



/// Returns a string containing "0" if the given object is nil or is not an NSNumber.
static inline NSString *zeroStringIfNil(id object)
{
    if ([object isKindOfClass:[NSNumber class]]) return StrFmt(@"%@", object);
    return @"0";
}



/// App delegate quick and dirty accessor.
#define g_appD ((AppDelegate *)[[UIApplication sharedApplication] delegate])



/// Assert if the method has not been subclassed.
#define ASSERT_SUBCLASS() { \
NSAssert(NO, @"Please subclass this method %s (class %s).", \
__PRETTY_FUNCTION__, __FILE__); }

#define ASSERT_SUBCLASS_RETURN_NIL() do { \
NSAssert(NO, @"Please subclass this method %s (class %s).", \
__PRETTY_FUNCTION__, __FILE__); return nil; } while(0)



/// Calls the block of code (passed as x) only once.
/// This can be used at several places in your code, because this is defined as a macro.
#define DO_THIS_ONLY_ONCE(x) \
do {\
    static BOOL alreadyExecutedOnce;\
    if (alreadyExecutedOnce == NO)\
    {\
        alreadyExecutedOnce = YES;\
        x();\
    }\
} while(0)



/// Calls the block of code (passed as x) only once every T seconds.
/// This can be used at several places in your code, because this is defined as a macro.
#define DO_THIS_ONLY_ONCE_EVERY_T_SECONDS(t, x) \
do {\
    static NSDate *lastActionDate = nil;\
    if ([[NSDate date] timeIntervalSinceDate:lastActionDate] > t || lastActionDate == nil)\
    {\
        lastActionDate = [NSDate date];\
        x();\
    }\
} while(0)



/// Calls the block only once every 1 hour.
#define DO_THIS_ONLY_ONCE_EVERY_HOUR(x) DO_THIS_ONLY_ONCE_EVERY_T_SECONDS(3600, x)



/// To be used on a category.
/// This will create a property using the associated property mechanism.
/// To use it, just add this to your .m, outside of your @implementation.
///
///     LAM_SYNTHESIZE_ASSOCIATED_PROPERTY(UITextField, NSNumber, bookmarkPage, setBookmarkPage)
///
/// This will create a setter and a getter named bookmarkPage and setBookmarkPage:. When set
/// the property will save its value to the user defaults. The getter will try to restore
/// its value from the user defaults when the instance variable is empty.
///
/// Optionnally, if needed, add a property declaration to your @interface.
///
///     LAM_SYNTHESIZE_ASSOCIATED_PROPERTY_ITF(Book, NSNumber, bookmarkPage)
///
#define LAM_SYNTHESIZE_ASSOCIATED_PROPERTY_ITF(SELF_CLASS, PROP_CLASS, INST_NAME) \
\
@interface SELF_CLASS (INST_NAME) \
@property (nonatomic, strong) PROP_CLASS *INST_NAME; \
@end

#define LAM_SYNTHESIZE_ASSOCIATED_PROPERTY(SELF_CLASS, PROP_CLASS, INST_NAME, SET_NAME) \
\
static char INST_NAME; \
\
@implementation SELF_CLASS (INST_NAME) \
\
- (PROP_CLASS *)INST_NAME \
{ \
    return objc_getAssociatedObject(self, &INST_NAME); \
} \
\
- (void)SET_NAME:(PROP_CLASS *)value \
{ \
    return objc_setAssociatedObject(self, &INST_NAME, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
} \
\
@end



/// Generate the sharedInstance method for a singleton class.
#define LAM_SYNTHESIZE_SINGLETON() \
+ (id)sharedInstance \
{ \
    static dispatch_once_t pred; \
    static id shared = nil; \
    \
    dispatch_once(&pred, ^ \
    { \
        shared = [[self alloc] init]; \
    }); \
    return shared; \
}



/// This will create a property synchronized with the NSUserDefaults.
/// To use it, just add this after the @end of your interface:
///
///     LAM_SYNTHESIZE_USER_DEFAULTS_PROPERTY_ITF(Book, NSNumber, bookmarkPage)
///
/// And add this to your .m, outside of your @implementation.
///
///     LAM_SYNTHESIZE_USER_DEFAULTS_PROPERTY(Book, NSNumber, bookmarkPage, setBookmarkPage, self.uid)
///
/// This will create a setter and a getter named bookmarkPage and setBookmarkPage:. When set
/// the property will save its value to the user defaults. The getter will try to restore
/// its value from the user defaults when the instance variable is empty.
///
#define LAM_SYNTHESIZE_USER_DEFAULTS_PROPERTY_ITF(SELF_CLASS, PROP_CLASS, INST_NAME) \
\
@interface SELF_CLASS (INST_NAME) \
@property (nonatomic, strong) PROP_CLASS *INST_NAME; \
@end

#define LAM_SYNTHESIZE_USER_DEFAULTS_PROPERTY(SELF_CLASS, PROP_CLASS, INST_NAME, SET_NAME, KEY) \
\
@interface SELF_CLASS () { PROP_CLASS *INST_NAME; } \
@end \
\
@implementation SELF_CLASS (INST_NAME) \
\
- (PROP_CLASS *)INST_NAME \
{ \
    if (INST_NAME != nil) return INST_NAME; \
    \
    NSString *key = StrFmt(@"%s_%@", xstr(INST_NAME), KEY); \
    PROP_CLASS *value = [[NSUserDefaults standardUserDefaults] valueForKey:key]; \
    if ([value isKindOfClass:[PROP_CLASS class]]) \
    { \
        INST_NAME = [value copy]; \
        LoggerModel(1, @"Loaded defaults value for %@: %@.", key, value); \
    } \
    \
    return INST_NAME; \
} \
\
- (void)SET_NAME:(PROP_CLASS *)value \
{ \
    if (INST_NAME != nil && [value isEqual:INST_NAME]) return; \
    \
    INST_NAME = [value copy]; \
    \
    NSString *key = StrFmt(@"%s_%@", xstr(INST_NAME), KEY); \
    [[NSUserDefaults standardUserDefaults] setValue:INST_NAME forKey:key]; \
    [[NSUserDefaults standardUserDefaults] synchronize]; \
    \
    LoggerModel(1, @"Saving defaults value for %@: %@.", key, value); \
} \
\
@end





