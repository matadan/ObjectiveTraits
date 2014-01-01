//
//  NSObject+PATraits.h
//  ObjectiveTrait
//
//  Created by Andrew Eades on 29/12/2013.
//

#import <Foundation/Foundation.h>

#import "NSObject+PATraits.h"

@interface NSObject (PATraits)

-(void)invoke:(NSString*)selectorName with:(NSArray*)args result:(void*)result;
-(void)invoke:(NSString*)selectorName result:(void*)result;

@end
