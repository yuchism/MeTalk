//
//  CLFMsgIdGenerator.h
//  CloseFriends
//
//  Created by John Y on 20/03/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTIdGenerator : NSObject
{
    NSInteger index;
}
+ (instancetype)sharedInstance;
- (NSString *) generateId;

@end
