//
//  MTRecorderController.m
//
//  Created by John Y on 17/04/2015.
//

#import "MTRecorderController.h"
#import "MTDuration.h"
#import <UIKit/UIKit.h>

#define kRecLevelTimerInterval 0.1f
#define kMinimumRecordingDuration 0.5f


@interface MTRecorderController ()
{
    AVAudioRecorder *_recorder;
    MTRecorderStatus _status;
    NSTimer *_timer;
    __weak id<MTRecorderControllerDelegate>_delegate;
    NSURL *_url;
    MTDuration *_recTimer;
    
    NSMutableArray *peaks;
}

@property(nonatomic,strong) AVAudioRecorder *recorder;
@property(nonatomic,strong) MTDuration *recTimer;
@end

@implementation MTRecorderController
@synthesize status = _status;
@synthesize delegate = _delegate;
@synthesize url = _url;
@synthesize recorder = _recorder;
@synthesize recTimer = _recTimer;

- (id) init
{
    self = [super init];
    if(self)
    {
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_resignActive:)
                                                     name:UIApplicationWillResignActiveNotification object:nil];

    }
    return self;
}

- (void)reset
{

    self.status = MTRecorderStatusInit;
    peaks = [NSMutableArray array];
}

- (void)start
{
    if(self.status == MTRecorderStatusInit)
    {
        self.status = MTRecorderStatusRecording;
    }
}

- (void)stop
{
    
    if(self.status == MTRecorderStatusRecording)
    {
        self.status = MTRecorderStatusDone;
        
        if([self.delegate respondsToSelector:@selector(shouldFinishRecording:)])
        {
            [self.delegate shouldFinishRecording:self];
        }
    }
}

- (void) setStatus:(MTRecorderStatus)status
{
    _status = status;
    if(status == MTRecorderStatusInit)
    {
        [self _prepareRecording];
    } else if (status == MTRecorderStatusRecording)
    {
        [self _startRecording];
    } else if(status == MTRecorderStatusDone)
    {
        [self _stopRecording];
    } else if(status == MTRecorderStatusError)
    {
        [self _stopRecording];
    }
}

- (void)_resignActive:(NSNotification *)noti
{
    [self stop];
}

- (void) dealloc
{
    [self _stopTimer];
    self.recorder.delegate = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self _unregisterAudiosessionInterruptHandler];
}

- (void) _prepareRecording
{
    _recTimer = [[MTDuration alloc] init];
    self.url = nil;
    
    NSURL *fileURL = [NSURL fileURLWithPath:[self _recodingFilePath]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             @(kAudioFormatMPEG4AAC), AVFormatIDKey,
                             @(16000.0), AVSampleRateKey,
                             @(1), AVNumberOfChannelsKey,
                             nil];
    NSError *error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:options error:&error];
    _recorder.delegate = self;
    [_recorder setMeteringEnabled:YES];
    [_recorder prepareToRecord];
    
    [_recTimer reset];
    
    if(error)
    {
        [self _didErrorOccur:error];
    }
}

- (void) _startRecording
{
    [self _registerAudiosessionInterruptHandler];
    [self.recTimer start];
    [self.recorder record];
    [self _startTimer];
    
    if([self.delegate respondsToSelector:@selector(didStartRecording:)])
    {
        [self.delegate didStartRecording:self];
    }
}

- (void) _stopRecording
{
    __weak typeof (self) sself = self;
    
    if ([[NSThread currentThread] isMainThread])
    {
        [self __stopRecording];
    } else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [sself __stopRecording];
        });
    }

}

- (void) __stopRecording
{
    [self.recTimer stop];
    // finish Recording
    [self.recorder stop];
    [self _stopTimer];
}


- (void) _startTimer
{
    [self _stopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:kRecLevelTimerInterval target:self selector:@selector(_timerCallback:) userInfo:nil repeats:YES];
    
}

- (void) _stopTimer
{
    if(_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void) _timerCallback:(NSTimer *)timer
{
    [_recorder updateMeters];
    CGFloat average = [self _convertValueForLevel:[_recorder averagePowerForChannel:0]];
    CGFloat peak = [self _convertValueForLevel:[_recorder averagePowerForChannel:0]];
    CGFloat duration = [_recTimer current];
    
    [peaks addObject:[NSNumber numberWithFloat:peak]];
    
    if([_delegate respondsToSelector:@selector(recorder:duration:averagePower:peekPower:)])
    {
        [_delegate recorder:self duration:@(duration) averagePower:@(average) peekPower:@(peak)];
    }

}

- (void) _didErrorOccur:(NSError *)error
{
    self.status = MTRecorderStatusError;
    
    if([_delegate respondsToSelector:@selector(recorder:didErrorOccur:)])
    {
        [_delegate recorder:self didErrorOccur:error];
    }
}

- (CGFloat) _convertValueForLevel:(CGFloat)power
{
    return pow (10, (0.05 * power));
}

- (NSString *) _recodingFilePath
{
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate];
    NSString * filename = [NSString stringWithFormat: @"%.0f.m4a",ti];
    NSString * targetFile = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
    
    return targetFile;
}

#pragma mark -- AVAudioRecorderDelegate
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
    [CATransaction begin];
    
    _url = [recorder url];

    if ([_recTimer current] < kMinimumRecordingDuration)
    {
        if([_delegate respondsToSelector:@selector(recorder:didErrorOccur:)])
        {
            [_delegate recorder:self didErrorOccur:nil];
        }
    } else
    {
        if(_url && flag && [_delegate respondsToSelector:@selector(recorder:didFinishRecording:duration:peaks:)])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            CGFloat duration = [_recTimer current];

            if ([[NSThread currentThread] isMainThread])
            {
                [_delegate recorder:self didFinishRecording:_url duration:@(duration) peaks:peaks];
            } else
            {
                dispatch_sync(mainQueue, ^(void) {
                    [_delegate recorder:self didFinishRecording:_url duration:@(duration) peaks:peaks];
                });
            }
        }
    }
    [CATransaction commit];
}


- (void) audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    [self _didErrorOccur:error];
}


- (void) _registerAudiosessionInterruptHandler
{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
}
- (void) _unregisterAudiosessionInterruptHandler
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO
                withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}


@end
