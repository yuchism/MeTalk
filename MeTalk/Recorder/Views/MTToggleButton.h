//
//  MTToggleButton.h
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 7..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTToggleButton : UIButton


@property(nonatomic,strong) UIImage *onImage;
@property(nonatomic,strong) UIImage *offImage;
@property(nonatomic,assign) BOOL isOn;
@end
