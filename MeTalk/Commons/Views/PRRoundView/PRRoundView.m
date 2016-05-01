//
//  PRRoundView.m
//  PoketRoket
//
//  Created by Yuch on 13. 7. 19..
//  Copyright (c) 2013년 yu chung hyun. All rights reserved.
//

#import "PRRoundView.h"

@implementation PRRoundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect) _roundRect
{
    float margin = 2;
    CGRect rect = CGRectMake(margin,margin,CGRectGetWidth(self.bounds) - margin * 2,CGRectGetHeight(self.bounds) - margin * 2);
    return rect;
}

- (void) _drawRectOption:(CGContextRef)contextRef
{
    CGContextSetRGBFillColor(contextRef, 255, 255, 255, 1);
    CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1);
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self _drawRectOption:contextRef];
    CGContextFillEllipseInRect(contextRef, [self _roundRect]);
    CGContextStrokeEllipseInRect(contextRef, [self _roundRect]);
}


@end
