//
//  DefaultGroup.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "DefaultGroup.h"
#import "ItemImpl.h"
#import "MTIdGenerator.h"

@interface DefaultGroup()
{
    NSString *mGroupTitle;
}
@end

@implementation DefaultGroup

- (id)init
{
    return [self initWithItem:nil];
}

- (id)initWithItem:(id<ItemImpl>)item
{
    self = [super init];
    if(self)
    {
        mGroupId = ([item groupId]) ? [item groupId] : [[MTIdGenerator sharedInstance] generateId];
        mGroupTitle = [NSString stringWithFormat:@"%@",[item groupId]];
    }
    return self;
    
}

- (NSString *)groupId
{
    return mGroupId;
}

- (NSString *)groupTitle
{
    return mGroupTitle;
}

@end