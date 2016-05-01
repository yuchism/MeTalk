//
//  NSMutableDictionary.h
//  CloseFriends
//
//  Created by John Y on 21/04/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(Validation)

- (void) setValidObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
