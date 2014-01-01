//
//  TMagnitude.m
//  ObjectiveTrait
//
//  Created by Andrew on 30/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//

#import "TMagnitude.h"

#import "PATrait.h"

#import "NSObject+PATraits.h"

@implementation TMagnitude

// compose the class at runtime to add in the Traits
+(void)initialize {
    
	if ([self class] == [TMagnitude class]) {
        
        [PATrait composeTraits:@[@"TEquality"] into:self];
    }
}

-(BOOL)greater:(NSObject*)object {
    
    BOOL isSmaller;
    BOOL isDifferent;
    
    // "greater" is defined in terms of "smaller & "differs"
    // but we do not know their implementations at compile time so we have to invoke them dynamically
    [self invoke:@"smaller:" with: @[object] result:&isSmaller];
    [self invoke:@"differs:" with: @[object] result:&isDifferent];
   
    return !isSmaller && isDifferent;
}

-(BOOL)betweenMinimum:(NSObject*)min andMaximum:(NSObject*)max {
    
    BOOL isMinSmallerThanSelf;
    BOOL isSelfSmallerThanMax;

    [min invoke:@"smaller:"  with: @[self] result:&isMinSmallerThanSelf];
    [self invoke:@"smaller:" with: @[max]  result:&isSelfSmallerThanMax];

    return isMinSmallerThanSelf && isSelfSmallerThanMax;
}


@end
