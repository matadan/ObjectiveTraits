//
//  TCircle.h
//  ObjectiveTrait
//
//  Created by Andrew on 29/12/2013.
//  Copyright (c) 2013 Perfect Agility. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TEquality.h"
#import "TMagnitude.h"

@interface TCircle : NSObject

-(double)area;

-(BOOL)equals:(TCircle*)circle;

-(BOOL)smaller:(TCircle*)object;

@end

// required methods

// -(NSPoint*)centre;
// -(double)radius;
