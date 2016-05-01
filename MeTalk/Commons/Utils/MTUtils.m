//
//  MTUtils.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 4. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTUtils.h"

@implementation MTUtils

+ (NSString *)durationToString:(CGFloat)time
{
    if (time < 0 ) {
        time = 0;
    }
    
    int min = floor(time / 60);
    int sec = floor(time - min * 60);
    
    NSString *minStr = [NSString stringWithFormat:@"%d", min];
    NSString *secStr = [NSString stringWithFormat:@"%02d", sec];
    
    return [NSString stringWithFormat:@"%@:%@", minStr, secStr];
}

@end
