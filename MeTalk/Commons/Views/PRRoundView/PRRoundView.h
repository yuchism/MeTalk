//
//  PRRoundView.h
//  PoketRoket
//
//  Created by Yuch on 13. 7. 19..
//  Copyright (c) 2013년 yu chung hyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRRoundView : UIView

- (CGRect) _roundRect;
- (void) _drawRectOption:(CGContextRef)contextRef;

@end
