//
//  MTAudio.h
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndexedItems.h"
#import <CoreLocation/CoreLocation.h>

@class MeTalkMedia;


@interface MTAudio : NSObject<ItemImpl>


@property (nonatomic, strong) NSString *mediaId;

@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSArray *audioPeaks;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) CLLocation *loc;
@property (nonatomic, strong) NSString *desc;

- (instancetype)initWithMetalkMedia:(MeTalkMedia *)media;

@end
