//
//  CLFMsgIdGenerator.m
//  CloseFriends
//
//  Created by John Y on 20/03/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import "MTIdGenerator.h"

@implementation MTIdGenerator


+ (instancetype)sharedInstance {
    static MTIdGenerator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^ {
        sharedInstance = [[MTIdGenerator alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        index = 0;
    }
    return self;
}


- (NSString *) generateId
{
    NSString *str = nil;
    @synchronized(self)
    {
        index = (index >= 3000000) ? 0 : index + 1;
        long long timeKey = [[NSDate date] timeIntervalSince1970] * 100;
        str = [NSString stringWithFormat:@"%llX%04lX",timeKey,(long)index];
    }
    return str;
}
@end
