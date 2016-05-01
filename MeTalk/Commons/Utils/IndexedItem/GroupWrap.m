//
//  GroupWrap.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "GroupWrap.h"


@implementation GroupWrap
@synthesize group,groupId;

- (id)initWithGroup:(id<GroupImpl>)aGroup
{
    self = [super init];
    if(self)
    {
        self.group = aGroup;
    }
    return self;
}

- (id)init
{
    return [self initWithGroup:nil];
}

- (NSString *)getGroupId
{
    return [self.group groupId];
}
@end
