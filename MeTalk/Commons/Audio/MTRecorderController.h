//
//  MTRecorderController.h
//
//  Created by John Y on 17/04/2015.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class MTRecorderController;

typedef enum {
    MTRecorderStatusError = 1,
    MTRecorderStatusInit,
    MTRecorderStatusRecording,
    MTRecorderStatusDone,
} MTRecorderStatus;

enum : NSInteger {
    MTRecorderStartRecordingError = 1,
    MTRecorderCancelRecordingError = 2,
    MTRecorderStopRecordingError = 3
};

    
@protocol MTRecorderControllerDelegate <NSObject>

@optional
- (void)recorder:(MTRecorderController *)controller duration:(NSNumber *)duration averagePower:(NSNumber *)average peekPower:(NSNumber *)peek;

- (void)recorder:(MTRecorderController *)controller didErrorOccur:(NSError *)error;

- (void)recorder:(MTRecorderController *)controller didFinishRecording:(NSURL *)fileURL duration:(NSNumber *)duration peaks:(NSArray *)peeks;

- (void)shouldFinishRecording:(MTRecorderController *)controller;
- (void)didStartRecording:(MTRecorderController *)controller;

@end


@interface MTRecorderController : NSObject<AVAudioRecorderDelegate>
- (void)start;
- (void)stop;
- (void)reset;

@property(nonatomic) MTRecorderStatus status;
@property(nonatomic,weak) id<MTRecorderControllerDelegate>delegate;
@property(nonatomic,strong) NSURL *url;
@end


