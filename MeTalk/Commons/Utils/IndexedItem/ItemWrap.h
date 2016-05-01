//
//  ItemWrap.h
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemImpl.h"

@interface ItemWrap : NSObject


- (id)initWithItem:(id<ItemImpl>)aItem;

@property(nonatomic,getter=getGroupId) NSString *groupId;
@property(nonatomic,getter=getItemId) NSString *itemId;
@property(nonatomic,strong) id<ItemImpl> item;
@end
