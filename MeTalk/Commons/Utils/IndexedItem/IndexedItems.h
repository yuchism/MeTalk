//
//  IndexedItems.h
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemImpl.h"
#import "GroupImpl.h"



@interface IndexedItems : NSObject
{
    NSMutableDictionary *mItemHash;
    NSMutableDictionary *mGroupHash;
    
    NSMutableArray *mItemList;
    NSMutableArray *mGroupList;
    
    NSMutableDictionary *mItemListPerGroupId;
}

@property(nonatomic,assign) Class groupClass;

- (void)addItem:(id<ItemImpl>)item;

- (NSInteger)numberOfGroups;
- (NSInteger)numberOfItems;
- (NSInteger)numberOfItemsPerGroup:(NSInteger)groupIdx;

- (id<ItemImpl>)itemForGroup:(NSInteger)groupIdx index:(NSInteger)itemIdx;
- (id<GroupImpl>)groupForIdx:(NSInteger)groupIdx;

@end
