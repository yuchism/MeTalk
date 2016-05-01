//
//  ItemWrap.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "ItemWrap.h"

@implementation ItemWrap
@synthesize groupId,itemId,item;

- (id)initWithItem:(id<ItemImpl>)aItem
{
    self = [super init];
    if(self)
    {
        self.item = aItem;
    }
    return self;
}

- (id)init
{
    return [self initWithItem:nil];
}

- (NSString *)getGroupId
{
    return [self.item groupId];
}
- (NSString *)getItemId
{
    return [self.item itemId];
}
@end