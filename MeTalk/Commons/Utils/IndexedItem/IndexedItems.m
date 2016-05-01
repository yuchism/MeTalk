//
//  IndexedItems.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "IndexedItems.h"
#import "ItemWrap.h"
#import "GroupWrap.h"
#import "DefaultGroup.h"


@implementation IndexedItems
@synthesize groupClass;

- (id)init
{
    self = [super init];
    if(self)
    {
        mItemHash = [NSMutableDictionary dictionary];
        mGroupHash = [NSMutableDictionary dictionary];
        mItemList = [NSMutableArray array];
        mGroupList = [NSMutableArray array];
        
        mItemListPerGroupId = [NSMutableDictionary dictionary];
        
        self.groupClass = [DefaultGroup class];
    }
    
    return self;
}

- (NSInteger)numberOfGroups
{
    return [mGroupList count];
}

- (NSInteger)numberOfItems
{
    return [mItemList count];
}

- (NSInteger)numberOfItemsPerGroup:(NSInteger)groupIdx
{
    GroupWrap *groupWrap = [mGroupList objectAtIndex:groupIdx];
    if(groupWrap)
    {
        NSMutableArray *itemList = [mItemListPerGroupId objectForKey:groupWrap.groupId];
        return [itemList count];
    }
    
    return 0;
}

- (id<ItemImpl>)itemForGroup:(NSInteger)groupIdx index:(NSInteger)itemIdx
{
    GroupWrap *groupWrap = [mGroupList objectAtIndex:groupIdx];
    if(groupWrap)
    {
        NSMutableArray *itemList = [mItemListPerGroupId objectForKey:groupWrap.groupId];
     
        ItemWrap *itemWrap = [itemList objectAtIndex:itemIdx];
        
        return itemWrap.item;
    }
    
    return nil;
}

- (id<GroupImpl>)groupForIdx:(NSInteger)groupIdx
{
    GroupWrap *groupWrap = [mGroupList objectAtIndex:groupIdx];
    if(groupWrap)
    {
        return groupWrap.group;
    }
    
    return nil;
}

- (void)addItem:(id<ItemImpl>)item
{
    ItemWrap *itemWrap = nil;
    if((itemWrap = [mItemHash objectForKey:[item itemId]]))
    {
        if ([itemWrap.groupId isEqualToString:[item groupId]])
        {
            itemWrap.item = item;
        } else
        {
            [self _moveItem:itemWrap item:item from:itemWrap.groupId to:[item groupId]];
        }
    } else
    {
        itemWrap = [[ItemWrap alloc] initWithItem:item];
        
        if(![mGroupHash objectForKey:itemWrap.groupId])
        {
            id<GroupImpl> group = [[self.groupClass alloc] initWithItem:item];
            [self _addGroup:group];
        }
        
        NSMutableArray *itemList = [mItemListPerGroupId objectForKey:itemWrap.groupId];
        [itemList addObject:itemWrap];
        
        [mItemHash setObject:itemWrap forKey:itemWrap.itemId];
        [mItemList addObject:itemWrap];
    }
}

- (void) _moveItem:(ItemWrap *)itemWrap
              item:(id<ItemImpl>)newItem
              from:(NSString *)fromGroupId
                to:(NSString *)toGroupId
{
    NSMutableArray *oldItemList = [mItemListPerGroupId objectForKey:fromGroupId];
    NSMutableArray *newItemList = [mItemListPerGroupId objectForKey:toGroupId];
    
    [oldItemList removeObject:itemWrap];
    [newItemList addObject:itemWrap];
    
    itemWrap.item = newItem;
    
}


- (void) _addGroup:(id<GroupImpl>)group;
{
    GroupWrap *groupWrap = nil;
    if((groupWrap = [mGroupHash objectForKey:[group groupId]]))
    {
        groupWrap.group = group;
    } else
    {
        groupWrap = [[GroupWrap alloc] initWithGroup:group];
        [mGroupHash setObject:groupWrap forKey:[group groupId]];
        [mGroupList addObject:groupWrap];
        
        NSMutableArray *newItemList = [NSMutableArray array];
        [mItemListPerGroupId setObject:newItemList forKey:[group groupId]];
    }
}

@end
