//
//  MTAudio.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTAudio.h"
#import "MeTalk-swift.h"

@implementation MTAudio
@synthesize mediaId,createDate,filePath,audioPeaks;

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.createDate = [NSDate date];
    }
    return self;
}


- (instancetype)initWithMetalkMedia:(MeTalkMedia *)media
{
    self = [super init];
    if(self)
    {
        self.createDate = media.createDate;
        self.filePath = media.filePath;
        self.mediaId = media.mediaId;
        self.audioPeaks = media.getAudioPeeksList;
        self.duration = media.duration;
        
        self.title = media.title;
        self.desc = media.desc;
        self.loc = media.getLocation;
        

        return self;
    }
    return self;
}

- (NSString *)itemId
{
    return self.mediaId;
}

- (NSString *)groupId
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    return [formatter stringFromDate:self.createDate];
}

@end
