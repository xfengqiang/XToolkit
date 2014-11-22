
#import "NSObject+TBKAssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (TBKAssociatedObject)

-(void) associateValue:(id)aValue withKey:(NSString *)aKey {
	objc_setAssociatedObject(self, [aKey UTF8String], aValue, TBKAssociationPolicyRetainNonatomic);
}

-(void) associateValue:(id)aValue withKey:(NSString *)aKey policy:(TBKAssociationPolicy)aPolicy;{
	objc_setAssociatedObject(self, [aKey UTF8String], aValue, aPolicy);
}

-(id) associatedValueForKey:(NSString *)aKey {
	return objc_getAssociatedObject(self, [aKey UTF8String]);
}

-(void) removeAssociatedValueForKey:(NSString *)aKey {
	[self associateValue:nil withKey:aKey policy:TBKAssociationPolicyAssign];
}

@end
