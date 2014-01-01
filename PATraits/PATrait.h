//
//  PATrait.h
//  ObjectiveTrait
//
//  Created by Andrew Eades on 29/12/2013.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

extern NSString* const kPATraitUndefined;

@interface PATrait : NSObject

@property NSString* name;
@property NSMutableDictionary* methodResolutions;


+(PATrait*)trait:(NSString*)aName;

+(void) composeTraits:(NSArray*)traits into:(Class)class;

+(PATrait*)resolve:(NSArray*)mappings trait:(NSString*)aName;

@end
