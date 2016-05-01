//
//  MTRecordButton.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTRecordButton.h"

@implementation MTRecordButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
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
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    

    [self setImage:[UIImage imageNamed:@"audioBtnRecording"] forState:UIControlStateNormal];
    
    
    [self _resizeFrame];

}

- (void)_resizeFrame
{
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
}

#pragma mark -- effect
- (void) setHighlighted: (BOOL) highlighted {
    [super setHighlighted: highlighted];
    self.alpha = highlighted ? 0.5f : 1.0f;
}

#pragma mark -- touch event handler
- (void)actionTouchDown:(id)sender
{
    NSLog(@"hi");
}
- (void)actionTouchUp:(id)sender
{
    NSLog(@"low");
}


@end
