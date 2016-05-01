//
//  NSMutableDictionary.m
//  CloseFriends
//
//  Created by John Y on 21/04/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import "NSMutableDictionary+Validation.h"

@implementation NSMutableDictionary(Validation)

- (void) setValidObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject == nil) {
        return;
    }

    [self setObject:anObject forKey:aKey];
}

@end
