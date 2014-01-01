//
//  PATrait.m
//  ObjectiveTrait
//
//  Created by Andrew Eades on 29/12/2013.
//

#import "PATrait.h"

@implementation PATrait

NSString* const kPATraitUndefined = @"";

+(PATrait*)trait:(NSString*)aName {
    PATrait* trait = [[self alloc] init];
    
    [trait setName:aName];
    
    [trait setMethodResolutions:[NSMutableDictionary dictionary]];

    return trait;
}

+(PATrait*)resolve:(NSArray*)mappings trait:(NSString*)aName{
    PATrait* trait = [self trait:aName];
    
    unsigned i;
    for (i = 0; i < [mappings count]; i += 2) {
        [[trait methodResolutions] setObject:[mappings objectAtIndex:(i+1)] forKey:[mappings objectAtIndex:i]];
    }
    
    return trait;
}

+(void) composeTraits:(NSArray*)traits into:(Class)composedClass {

    NSLog(@"Composing class %@", [composedClass description]);
    
    // remember all the methods added into the class so that we can detect conflicts
    NSMutableDictionary* addedMethods = [NSMutableDictionary dictionary];
    
    // make a list of methods that are required to give a default implementation to once the traits have been composed
    
    // add methods from composed class so that we don't try to override them
    unsigned int methodCount = 0;
    Method* methods = class_copyMethodList(composedClass, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        Method m = methods[i];

        SEL name = method_getName(m);
        IMP imp = method_getImplementation(m);

        NSString* impPointer = [NSString stringWithFormat:@"%p", imp];
        
        [addedMethods setObject:impPointer forKey:[NSString stringWithFormat:@"%s", sel_getName(name)]];
        
        NSLog(@"Added method %s from composing class", sel_getName(name));
    }
    
    if (methods) {
        free(methods);
    }

    // iterate through traits to compose
    for (id aTrait in traits) {
        Class traitClass;
        PATrait* trait;
        
        // we allow strings as a shorthand to a trait, so convert strings to traits
        // and make an appropriate trait class
        if ([[aTrait class] isSubclassOfClass:[NSString class]]) {
            
            traitClass = NSClassFromString(aTrait);
            trait = [PATrait trait:aTrait];
            
        } else if ([[aTrait class] isSubclassOfClass:[PATrait class]]) {
            
            traitClass = NSClassFromString([aTrait name]);
            trait = aTrait;
        }
        
        if (!traitClass) {
            NSLog(@"Class not found %@", trait);
        }
        
        // add methods to composedClass
        NSLog(@"Scanning class %@", [[traitClass class] description]);
      
        unsigned int methodCount = 0;
        Method* methods = class_copyMethodList(traitClass, &methodCount);
        for (int i = 0; i < methodCount; i++) {
            Method m = methods[i];
            
            SEL name = method_getName(m);
          
            // is there a resolve for this method?
            NSString* methodKey = [NSString stringWithUTF8String:sel_getName(name)];
            NSString* resolve = [[trait methodResolutions] objectForKey:methodKey];
            
            if (resolve) {
                
                if (NSOrderedSame != [resolve compare:kPATraitUndefined]) {
                    //  change the name
                    NSLog(@"Resolving method %s by renaming it to %@", sel_getName(name), resolve);
                    
                    name = NSSelectorFromString(resolve);
                    
                } else {
                    // miss this one out
                    NSLog(@"Resolving method %s by removing it", sel_getName(name));
                    
                    continue;
                }
            }
            
            IMP imp = method_getImplementation(m);
            const char* types = method_getTypeEncoding(m);
            
            NSString* existingImplementation = [addedMethods objectForKey:[NSString stringWithUTF8String:sel_getName(name)]];
            
            if (existingImplementation) {
                NSString* currentImplementation = [NSString stringWithFormat:@"%p", imp];

                if ([existingImplementation compare:currentImplementation] != NSOrderedSame) {
                    NSException* exception = [NSException exceptionWithName:@"method conflict" reason:[NSString stringWithFormat:@"Traits exception: method conflict: %s already defined", sel_getName(name)] userInfo:nil];
                
                    [exception raise];
                } else {
                    NSLog(@"Reusing method %s", sel_getName(name));
                }
                
            }
            else {
                
                if (class_addMethod(composedClass, name, imp, types)) {
                    NSString* impPointer = [NSString stringWithFormat:@"%p", imp];
                    
                    NSString* methodName = [NSString stringWithFormat:@"%s", sel_getName(name)];
    
                    [addedMethods setObject:impPointer forKey:methodName];
                    
                    NSLog(@"Added method %s %p", sel_getName(name), imp);
                } else {
                    NSLog(@"Couldn't add method %s", sel_getName(name));
                }
            }
        }
        
        if (methods) {
            free(methods);
        }
    }
    
    NSLog(@"---");

}

@end
