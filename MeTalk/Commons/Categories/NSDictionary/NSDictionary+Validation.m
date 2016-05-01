//
//  NSDictionary+Validation.m
//  CloseFriends
//
//  Created by John Y on 7/04/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import "NSDictionary+Validation.h"

@implementation NSDictionary(Validation)

- (id) validObjectForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if([object isEqual:[NSNull null]])
    {
        return nil;
    }
    return object;
}

- (id) validObjectForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object isEqual:[NSNull null]])
    {
        return nil;
    }
    return object;
}

- (NSInteger) integerForKey:(id)akey
{
    id object = [self validObjectForKey:akey];
    if([object isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)object integerValue];
    }
    
    return 0;
}


- (double) doubleForKey:(id)aKey
{
    id object = [self validObjectForKey:aKey];
    if([object isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)object doubleValue];
    } else if([object isKindOfClass:[NSString class]])
    {
        return [object doubleValue];
    }
    
    return 0.0f;
}

@end
