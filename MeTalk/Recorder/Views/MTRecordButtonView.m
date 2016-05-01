//
//  MTRecordButtonView.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTRecordButtonView.h"
#import "MTMacros.h"
@interface MTRecordButtonView()


@property (unsafe_unretained, nonatomic) IBOutlet UIView *bgView;
@end

@implementation MTRecordButtonView


#pragma mark - initialize
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
    
    }
    return self;
}

- (instancetype)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    if([self.subviews count] == 0)
    {
        MTRecordButtonView *view = [self loadNib];
        view.frame = self.frame;
        view.autoresizingMask = self.autoresizingMask;
        
        [view setTranslatesAutoresizingMaskIntoConstraints:self.translatesAutoresizingMaskIntoConstraints];
        
        for (NSLayoutConstraint *constraint in self.constraints)
        {
            id firstItem = constraint.firstItem;
            if (firstItem == self)
            {
                firstItem = view;
            }
            id secondItem = constraint.secondItem;
            if (secondItem == self)
            {
                secondItem = view;
            }
            [view addConstraint:
            [NSLayoutConstraint constraintWithItem:firstItem
                                      attribute:constraint.firstAttribute
                                      relatedBy:constraint.relation
                                         toItem:secondItem
                                      attribute:constraint.secondAttribute
                                     multiplier:constraint.multiplier
                                       constant:constraint.constant]];
        }
        
        
        return view;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self initialize];
}

- (MTRecordButtonView *)loadNib
{
    return [[[NSBundle bundleForClass:self.class] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] firstObject];
}

- (void)initialize
{
    self.plotView.mode = UCPlotViewModeMetering;
    self.plotView.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = ColorFromRGBA(0x11, 0x11, 0x11, 0.10);
    self.bgView.backgroundColor = [UIColor redColor];
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -

@end
