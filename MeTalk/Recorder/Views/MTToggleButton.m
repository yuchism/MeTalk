//
//  MTToggleButton.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 7..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTToggleButton.h"

@interface MTToggleButton()
{
    BOOL _isOn;
}
@end

@implementation MTToggleButton
@synthesize onImage,offImage;
@synthesize isOn = _isOn;

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initialize];
    }
    return self;
}


- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {

    }
    return self;
}


- (void)awakeFromNib
{
    [self initialize];
}

- (void) initialize
{
    self.onImage = [UIImage imageNamed:@"audioBtnPauseR"];
    self.offImage = [UIImage imageNamed:@"audioBtnPlayR"];

    
    [self setBackgroundColor:[UIColor clearColor]];
    self.isOn = NO;
}

- (void)setIsOn:(BOOL)isOn
{
    UIImage *image = (isOn) ? self.onImage : self.offImage;
    
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
    [self setImage:image forState:UIControlStateSelected];
    
    _isOn = isOn;
}




@end
