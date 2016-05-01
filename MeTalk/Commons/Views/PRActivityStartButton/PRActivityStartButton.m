//
//  PRActivityStartButton.m
//  PoketRoket
//
//  Created by Yuch on 13. 6. 27..
//  Copyright (c) 2013년 yu chung hyun. All rights reserved.
//

#import "PRActivityStartButton.h"
#import "MTMacros.h"
#define kTimeInterval 0.01

@implementation PRActivityStartButton
@synthesize on = _isOn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _longGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionLongPress:)];
    _longGr.minimumPressDuration = 0.0;
    _tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start_icon.png"]];
    _imgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    _imgView.userInteractionEnabled = NO;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:NO];
    [self addSubview:_imgView];
    [self _createLayer];
    
    
    self.on = NO;

}

- (void) dealloc
{
    self.delegate = nil;
}


- (void) setOn:(BOOL)on
{
    _isOn = on;
    if(!on)
    {
        [_imgView setImage:[UIImage imageNamed:@"start_icon.png"]];
        [self removeGestureRecognizer:_longGr];
        [self removeGestureRecognizer:_tapGr];
        [self addGestureRecognizer:_tapGr];

    } else{
        [_imgView setImage:[UIImage imageNamed:@"pause_icon.png"]];
        [self removeGestureRecognizer:_tapGr];
        [self removeGestureRecognizer:_longGr];
        [self addGestureRecognizer:_longGr];
        
    }
}


- (void)_incrementCounter {
    self.counter++;
    [self _repositionLayer];
}

- (void)actionTap:(UITapGestureRecognizer *)gr
{
    if([self.delegate respondsToSelector:@selector(activityStartButtonActionStart:)])
    {
        [self.delegate activityStartButtonActionStart:self];
    }
}

- (void)actionLongPress:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        self.counter = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(_incrementCounter) userInfo:nil repeats:YES];
        _isLongPressSucceed = NO;
    }
}


- (void) _longPressDone
{
    if([self.delegate respondsToSelector:@selector(activityStartButtonActionStop:)] && _isLongPressSucceed == YES)
    {
        [self.delegate activityStartButtonActionStop:self];
    }
    
    [self.timer invalidate];
    self.timer = nil;
    self.counter = 0;
    _isLongPressSucceed = NO;
    [self _repositionLayer];
}


- (void) _drawRectOption:(CGContextRef)contextRef
{
    CGContextSetRGBFillColor(contextRef, 0x00, 0x00, 0x00, 1.0);
    CGContextSetRGBStrokeColor(contextRef, 0x00, 0x00, 0x00, 1.0);
}

- (void) _createLayer
{
    _baseLayer = [CAShapeLayer layer];
    [_baseLayer setFillColor:ColorFromRGBA(0xFF,0xFF,0Xff,0.75).CGColor];
    [self.layer addSublayer:_baseLayer];
}

- (void) _repositionLayer
{
    CGPoint center = CGPointMake(CGRectGetWidth([self _roundRect]) / 2 + 2, CGRectGetHeight([self _roundRect]) / 2 + 2);
    CGFloat _percent = _counter * 24;
    if(_percent <= 360)
    {
        CGFloat delta = [self degreesToRadians:_percent];
        CGFloat innerRadius = 36.5;
        CGFloat outerRadius = innerRadius + 13;
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRelativeArc(path, NULL, center.x, center.y, innerRadius, -(M_PI / 2), delta);
        CGPathAddRelativeArc(path, NULL, center.x, center.y, outerRadius, delta - (M_PI / 2), -delta);
        CGPathAddLineToPoint(path, NULL, center.x, center.y-innerRadius);
        _baseLayer.path = path;
        CGPathRelease(path);
    } else {
        _isLongPressSucceed = YES;
        [self _longPressDone];
    }

}

- (CGFloat) degreesToRadians:(CGFloat) degrees
{
    return degrees * M_PI / 180;
};

@end
