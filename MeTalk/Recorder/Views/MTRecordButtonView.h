//
//  MTRecordButtonView.h
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 6..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTRecordButton.h"
#import "UCPlotView.h"

@interface MTRecordButtonView : UIView


@property (weak, nonatomic) IBOutlet UCPlotView *plotView;
@property (weak, nonatomic) IBOutlet MTRecordButton *recordButton;

@end
