//
//  CLFDuration.m
//  CloseFriends
//
//  Created by John Y on 29/04/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import "MTDuration.h"

@implementation MTDuration

- (id)init
{
    self = [super init];
    if(self)
    {
        [self reset];
    }
    return self;
}

- (void)reset
{
    _duration = 0.0f;
    _baseDate = nil;
}

- (void) start
{
    _baseDate = [NSDate date];
}

- (NSTimeInterval) _getDiff
{
    if(_baseDate)
    {
        NSTimeInterval base = [_baseDate timeIntervalSince1970];
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        
        NSTimeInterval diff = now - base;
        
        return diff;
    }
    
    return 0.0f;
}

- (NSTimeInterval) current
{
    return _duration + [self _getDiff];
}

- (void) stop
{
    _duration += [self _getDiff];
    _baseDate = nil;
}


@end
