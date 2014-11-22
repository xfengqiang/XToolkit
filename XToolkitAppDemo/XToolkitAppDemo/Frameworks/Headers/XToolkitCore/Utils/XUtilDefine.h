//
//  XUtilDefine.h
//  XToolkit
//
//  Created by frank.xu on 11/13/12.
//  Copyright (c) 2012 Frank. All rights reserved.
//

#ifndef XToolkit_XUtilDefine_h
#define XToolkit_XUtilDefine_h
#import <objc/runtime.h>

///////////////////////////////////////////////////////////////////////////////////////////////////
// Flags

/**
 * For when the flag might be a set of bits, this will ensure that the exact set of bits in
 * the flag have been set in the value.
 */
#define IS_MASK_SET(value, flag)  (((value) & (flag)) == (flag))


//Assgin value to a pointer
#define assginPtrValue(ptr, v) \
if(ptr)\
{ \
    *ptr = v; \
}

/** 
 * Singleton
 */
#define SINGLETON_FOR_CLASS_HEADER(SS_CLASSNAME)	\
\
+ (SS_CLASSNAME*) sharedInstance;

#define SINGLETON_FOR_CLASS_IMPLEMENTION(SS_CLASSNAME)\
\
+ (SS_CLASSNAME*) sharedInstance	\
{\
    static SS_CLASSNAME *instance;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    instance = [[SS_CLASSNAME alloc] init];\
});\
return instance;\
}\

/**
 * Print result or error
 */
#define LogResult(result, error)  \
if(error) \
{ \
    NSLog(@"Error occurred:%@", error); \
} \
else \
{ \
    NSLog(@"Result ok:%@", result); \
}


/**
 * Check empty string
 */
#define NotEmptyStr(s) (s==nil || [s trimedString].length == 0)
#define NoneNilStr(s) ((s == nil) ? @"" : s)

/**
 * Add dynimic object property to category
 */
#define DYN_SYNTHSIZE_FOR_OBJECT(class_type,propertyName, PropertyName) \
static char propertyName##Key;  \
- (class_type)propertyName \
{ \
     return objc_getAssociatedObject(self, &propertyName##Key); \
} \
- (void)set##PropertyName:(class_type)value \
{ \
    objc_setAssociatedObject(self, &propertyName##Key, value, OBJC_ASSOCIATION_RETAIN); \
} 

/**
 * Add dynimic int property to category
 */
#define DYN_SYNTHSIZE_FOR_INTEGER_X(propertyName, PropertyName, defalutValue) \
static char propertyName##Key;  \
- (NSInteger)propertyName \
{ \
    NSNumber  *number = objc_getAssociatedObject(self, &propertyName##Key); \
    if(number) \
    { \
        return [number intValue]; \
    }  \
    return defalutValue; \
}  \
- (void)set##PropertyName:(NSInteger)value \
{   \
    objc_setAssociatedObject(self, &propertyName##Key, [NSNumber numberWithInt:value], OBJC_ASSOCIATION_RETAIN);\
}

/**
 * Add dynimic int property to category
 */
#define DYN_SYNTHSIZE_FOR_INTEGER(propertyName, PropertyName) DYN_SYNTHSIZE_FOR_INTEGER_X(propertyName, PropertyName, 0)

/**
 * Add dynimic int property to category
 */
#define DYN_SYNTHSIZE_FOR_BOOL_X(propertyName, PropertyName, defalutValue) \
static char propertyName##Key;  \
- (BOOL)propertyName \
{ \
    NSNumber  *number = objc_getAssociatedObject(self, &propertyName##Key); \
    if(number) \
    { \
        return [number intValue]; \
    }  \
    return defalutValue; \
}  \
- (void)set##PropertyName:(BOOL)value \
{   \
    objc_setAssociatedObject(self, &propertyName##Key, [NSNumber numberWithBool:value], OBJC_ASSOCIATION_RETAIN);\
}

/**
 * Add dynimic int property to category
 */
#define DYN_SYNTHSIZE_FOR_BOOL(propertyName, PropertyName) DYN_SYNTHSIZE_FOR_BOOL_X(propertyName, PropertyName, NO)

/**
 * Log function call
 */
#define LogFun(str) NSLog(@"===%s===msg:%@", __FUNCTION__, str); 



#ifndef X_STRONG
#if __has_feature(objc_arc)
#define X_STRONG strong
#else
#define X_STRONG retain
#endif
#endif

#ifndef X_WEAK
#if __has_feature(objc_arc_weak)
#define X_WEAK weak
#elif __has_feature(objc_arc)
#define X_WEAK unsafe_unretained
#else
#define X_WEAK assign
#endif
#endif


#endif


