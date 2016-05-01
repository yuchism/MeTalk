//
//  GroupWrap.h
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupImpl.h"

@interface GroupWrap : NSObject


- (id)initWithGroup:(id<GroupImpl>)aGroup;


@property(nonatomic,getter=getGroupId) NSString *groupId;
@property(nonatomic,strong) id<GroupImpl>group;
@end