//
//  TColor.m
//  ObjectiveTrait
//
//  Created by Andrew on 30/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//

#import "TColor.h"

#import "PATrait.h"

#import "NSObject+PATraits.h"

@implementation TColor

// compose the class at runtime to add in the Traits
+(void)initialize {
    
	if ([self class] == [TColor class]) {
        
        [PATrait composeTraits:@[[PATrait trait:@"TEquality"]] into:self];
    }
}

// required by TEquality
-(BOOL)equals:(NSString*)object {
    NSString* color;
    
    [self invoke:@"color" with: @[object] result:&color];

    return ![color compare:object];
}

@end
