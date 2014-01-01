//
//  NSObject+PATraits.m
//  ObjectiveTrait
//
//  Created by Andrew Eades on 29/12/2013.
//


@implementation NSObject (PATraits)

-(void)invoke:(NSString*)selectorName with:(NSArray*)args result:(void*)result {
    SEL selector = NSSelectorFromString(selectorName);
    
    Class class = [self class];
    NSMethodSignature * mySignature = [class instanceMethodSignatureForSelector:selector];
    
    NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature:mySignature];
    
    NSObject* myTraits = self;
    [myInvocation setTarget:myTraits];
    [myInvocation setSelector:selector];
    
    if ([args count]) {
        int index = 2;
        for (id arg in args) {
            [myInvocation setArgument:(void*)&arg atIndex:index];
            index++;
        }       
    }
    
    [myInvocation invoke];
    
    [myInvocation getReturnValue:result];
    
}

// no arguments version
-(void)invoke:(NSString*)selectorName result:(void*)result {
    [self invoke:selectorName with:@[] result:result];
}


@end
