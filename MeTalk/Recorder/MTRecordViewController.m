//
//  MTRecordViewController.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 3. 23..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//


#import "MTRecordViewController.h"
#import "MTRecorderController.h"
#import "MTMacros.h"

#import "MTAudio.h"
#import "MTIdGenerator.h"
#import "UCPlotView.h"
#import "MeTalk-swift.h"



@interface MTRecordViewController()
<MTRecorderControllerDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet MTRecordButtonView *buttonView;
@property (weak, nonatomic) IBOutlet PRCurrentPaceGraphView *graphView;
@property(nonatomic) MTRecorderController *recorder;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end


@implementation MTRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    view.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:view];
    [self.view sendSubviewToBack:view];
    
    self.recorder = [[MTRecorderController alloc] init];
    self.recorder.delegate = self;
    [self.recorder reset];

    [self.graphView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:ColorFromRGBA(0x32, 0x32, 0x32,0.7)];
    [self.bgView setBackgroundColor:ColorFromRGBA(0x32, 0x32, 0x32,0.1)];
    [self.buttonView setBackgroundColor:ColorFromRGBA(0x32, 0x32, 0x32, 1.0)];
    [self.buttonView.recordButton addTarget:self action:@selector(actionTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.buttonView.recordButton addTarget:self action:@selector(actionTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)actionTouchDown:(id)sender
{
    [self.recorder start];
}

- (void)actionTouchUp:(id)sender
{
    [self.recorder stop];
}

- (IBAction)actionListDown:(id)sender
{


}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    [self.graphView setNeedsUpdateConstraints];

}


#pragma mark -- MTRecorderControllerDelegate

- (void)shouldFinishRecording:(MTRecorderController *)controller
{
    [self.buttonView.recordButton setEnabled:NO];
}

- (void)recorder:(MTRecorderController *)controller didErrorOccur:(NSError *)error
{
    [self.buttonView.recordButton setEnabled:YES];
    [self.buttonView.plotView reset];
    [self.recorder reset];
}

- (void)recorder:(MTRecorderController *)controller didFinishRecording:(NSURL *)fileURL duration:(NSNumber *)duration peaks:(NSArray *)peaks
{
    [self.buttonView.recordButton setEnabled:YES];
    [self.buttonView.plotView reset];
    [self.recorder reset];
    

    MTAudio *audio = [[MTAudio alloc] init];
    audio.mediaId = [[MTIdGenerator sharedInstance] generateId];
    audio.audioPeaks = peaks;
    audio.filePath = [fileURL path];
    audio.duration = duration;
    
    [[MTStorageService sharedInstance] saveAudio:audio complete:^(NSError * _Nullable error) {
        
    }];
    
    MTAudioPlayerViewController *playerVC = [[MTAudioPlayerViewController alloc] init];
    playerVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    playerVC.audio = audio;
    [self presentViewController:playerVC animated:NO completion:nil];

    __weak typeof(self) weakSelf = self;
    
    playerVC.onAudioPlayFinished = ^(){
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            
        }];
    };
    
    
}
- (void)recorder:(MTRecorderController *)controller duration:(NSNumber *)duration averagePower:(NSNumber *)average peekPower:(NSNumber *)peek
{
    [self.buttonView.plotView addCurrentPeak:average];
    [self.graphView movePosition:[average doubleValue]];
}
@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

