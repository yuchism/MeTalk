//
//  CLFDuration.h
//  CloseFriends
//
//  Created by John Y on 29/04/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDuration : NSObject
{
    NSDate *_baseDate;
    NSTimeInterval _duration;
}

- (void) start;
- (void) stop;
- (void) reset;
- (NSTimeInterval) current;

@end