//
//  Circle.h
//  ObjectiveTrait
//
//  Created by Andrew on 31/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCircle.h"

@interface Circle : NSObject

@property NSPoint   centre;
@property double    radius;
@property NSString* color;

- (Circle*)initWithCentre:(NSPoint)theCentre radius:(double)theRadius color:(NSString*)theColor;


@end
