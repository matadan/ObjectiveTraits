//
//  AppDelegate.m
//  ObjectiveTraitsDemo
//
//  Created by Andrew on 01/01/2014.
//  Copyright (c) 2014 Perfect Agility. All rights reserved.
//

#import "AppDelegate.h"

#import "Circle.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSPoint centre = {10.0, 10.0};
    double radius = {1.0};
    
    id circleA = [[Circle alloc] initWithCentre:centre radius: radius color:@"red"];
    id circleB = [[Circle alloc] initWithCentre:centre radius:radius color:@"red"];
    
    BOOL resultA = [circleA equals:circleB];
    NSLog(@"Result equals: %d", resultA);
    
    BOOL resultB = [circleA differs:circleB];
    NSLog(@"Result differs: %d", resultB);
}

@end
