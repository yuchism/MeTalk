//
//  MTHistorySectionHeaderView.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 4. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTHistorySectionHeaderView.h"
#import "MTMacros.h"

@interface MTHistorySectionHeaderView()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation MTHistorySectionHeaderView

- (void)awakeFromNib
{
    [self.lblTitle setTextColor:ColorFromRGBA(0x00,0x00,0x00,0.5)];
}

- (void)setTitle:(NSString *)str
{
    [self.lblTitle setText:str];
}
@end
