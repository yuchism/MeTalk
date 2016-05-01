//
//  PRActivityStartButton.h
//  PoketRoket
//
//  Created by Yuch on 13. 6. 27..
//  Copyright (c) 2013년 yu chung hyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PRRoundView.h"

@class PRActivityStartButton;

@protocol PRActivityStartButtonDelegate <NSObject>

- (void)activityStartButtonActionStart:(PRActivityStartButton *)btn;

- (void)activityStartButtonActionStop:(PRActivityStartButton *)btn;

@end

@interface PRActivityStartButton : PRRoundView
{
    BOOL _isOn;
    UILongPressGestureRecognizer *_longGr;
    UITapGestureRecognizer *_tapGr;
    NSUInteger _counter;
    NSTimer *_timer;
    UIImageView *_imgView;
    CAShapeLayer *_baseLayer;
    BOOL _isLongPressSucceed;
}


@property(nonatomic,assign) BOOL on;
@property(nonatomic,assign) NSUInteger counter;
@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,assign) id <PRActivityStartButtonDelegate> delegate;
@end
