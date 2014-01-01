//
//  TEquality.m
//  ObjectiveTrait
//
//  Created by Andrew Eades on 27/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//


#import "TEquality.h"

#import "NSObject+PATraits.h"

@implementation TEquality

// implementation of methods that are known at compile time
- (BOOL) differs:(NSObject*)object {
    BOOL isEqual;

    // "differs" is defined in terms of "equals"
    // but we do not know how "equals" is implemented at compile time so we have to invoke it dynamically
    
    // isEqual = [self equals:object]; becomes:
    [self invoke:@"equals:" with: @[object] result:&isEqual];
    
    return !isEqual;
}

@end
