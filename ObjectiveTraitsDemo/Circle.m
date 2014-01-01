//
//  Circle.m
//  ObjectiveTrait
//
//  Created by Andrew on 31/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//

#import "Circle.h"

#import "PATrait.h"

@implementation Circle

// compose the class at runtime to add in the traits
+(void)initialize {
	if ([self class] == [Circle class]) {
        
        [PATrait composeTraits:@[@"TCircle"] into:self];
        
    }
}

- (Circle*)initWithCentre:(NSPoint)theCentre radius:(double)theRadius color:(NSString*)theColor {
    
    self = [super init];
    
    [self setCentre:theCentre];
    [self setRadius:theRadius];
    
    [self setColor:theColor];
    
    return self;
}

@end
