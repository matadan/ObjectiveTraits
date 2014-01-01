//
//  TMagnitude.h
//  ObjectiveTrait
//
//  Created by Andrew on 30/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEquality.h"

@interface TMagnitude : NSObject

-(BOOL)greater:(NSObject*)magnitude;
-(BOOL)betweenMinimum:(NSObject*)min andMaximum:(NSObject*)max;

@end

// required methods

// -(BOOL)smaller:(NSObject*)magnitude;
// -(BOOL)differs:(NSObject*)magnitude;
