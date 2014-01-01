//
//  TCircle.m
//  ObjectiveTrait
//
//  Created by Andrew on 29/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//

#import "TCircle.h"

#import "NSObject+PATraits.h"

#import "PATrait.h"

@implementation TCircle

// compose the class at runtime to add in the Traits
+(void)initialize {
	if ([self class] == [TCircle class]) {
         
        [PATrait composeTraits:@[
                               
            @"TMagnitude",
            @"TEquality",
            [PATrait resolve: @[@"equals:", @"equalsColor:"] trait:@"TColor"]
        
        ] into:self];

    }
}

// required by TEquality
- (BOOL)equals:(NSObject*)object {
    
    BOOL result;
    
    NSPoint centreA;
    [self invoke:@"centre" result:&centreA];
    
    double radiusA;
    [self invoke:@"radius" result:&radiusA];

    NSPoint centreB;
    [object invoke:@"centre" result:&centreB];
    
    double radiusB;
    [object invoke:@"radius" result:&radiusB];

    result =   (centreA.x == centreB.x)
            && (centreA.y == centreB.y)
            && (radiusA == radiusB);
                                                                                    
    return result;
}

// required by TMagnitude
-(BOOL)smaller:(TCircle*)object {
    double radiusA;
    [self invoke:@"radius" result:&radiusA];
 
    double radiusB;
    [object invoke:@"radius" result:&radiusB];

    return radiusA < radiusB;
}

-(double)area {
    double radius;
    [self invoke:@"radius" result:&radius];
    
    return M_PI * radius * radius;
}


@end
