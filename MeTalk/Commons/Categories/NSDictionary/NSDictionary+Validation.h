//
//  NSDictionary+Validation.h
//  CloseFriends
//
//  Created by John Y on 7/04/2015.
//  Copyright (c) 2015 CloseFriends. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(Validation)

- (id) validObjectForKey:(id)aKey;
- (id) validObjectForKeyPath:(NSString *)keyPath;
- (NSInteger) integerForKey:(id)akey;

- (double) doubleForKey:(id)aKey;

@end
