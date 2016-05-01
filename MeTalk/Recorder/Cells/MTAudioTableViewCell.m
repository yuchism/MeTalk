//
//  MTAudioTableViewCell.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 7..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTAudioTableViewCell.h"
#import "UCPlotView.h"
#import "MTMacros.h"

@interface MTAudioTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UCPlotView *plotView;

@end

@implementation MTAudioTableViewCell

- (void)awakeFromNib {
    // Initialization code
//UIEdgeInsetsMake(20, 5, 5, 10);
//UIEdgeInsetsMake(20, 10, 5, 5)
    
    self.contentView.backgroundColor = ColorFromRGBA(0xf0, 0x00, 0x00, 0.1);
    self.plotView.backgroundColor = [UIColor clearColor];
    self.plotView.plotColor = ColorFromRGBA(0x9c,0x00,0x00,0.9);
    self.plotView.plotWidth = 2.0f;
    self.plotView.mode = UCPlotViewModeProgress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTime:(NSString *)str
{
    [self.lblTime setText:str];
}

- (void)setPlots:(NSArray *)plots
{
    [self.plotView setPeeks:plots];
}
@end
