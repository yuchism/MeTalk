//
//  MTAudioPlayer.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 4. 28..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//


import UIKit
import AVFoundation


class MTAudioPlayer: NSObject,AVAudioPlayerDelegate {

    var onAudioFinish:(()->Void)?
    var onAudioStart:(()->Void)?
    var onAudioProgress:((Double?,Double?)->Void)?
    var onAudioError:((NSError)->Void)?
    
    var player:AVAudioPlayer?
    var timer:NSTimer?
    


    
    
    internal func play(data:NSData?)->Void {
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try player = AVAudioPlayer(data: data!)
            
            if self.onAudioStart != nil {
                self.onAudioStart!();
            }
            self.startTimer();
            
            player?.delegate = self;
            player?.prepareToPlay();
            player?.play();
        
        }catch let error as NSError
        {
            self.stopTimer();
            
            if self.onAudioError != nil {
                self.onAudioError!(error);
            }
        }
    }

    private func startTimer()->Void {
        
        self.stopTimer();
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:#selector(MTAudioPlayer.tick), userInfo: nil, repeats:true);
        
    }
    
    private func stopTimer()-> Void {
        self.timer?.invalidate();
        self.timer = nil;
    }
    
    
    @objc private func tick() -> Void {
        if self.onAudioProgress != nil {
            self.onAudioProgress!(self.player?.duration,self.player?.currentTime);
        }
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        self.stopTimer();
        
        if self.onAudioFinish != nil {
            self.onAudioFinish!()
        }
    }


}
