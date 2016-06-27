//
//  MTRecordViewController.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 6. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit


extension MTRecordViewController:MTRecorderControllerDelegate
{
    func shouldFinishRecording(controller: MTRecorderController!) {
        recordButton.enabled = false
    }
    
    func recorder(controller: MTRecorderController!, didErrorOccur error: NSError!) {
        recordButton.enabled = true
        recorder.reset()
    }
    
    
    func recorder(controller: MTRecorderController!, duration: NSNumber!, averagePower average: NSNumber!, peekPower peek: NSNumber!) {
        graphView.movePosition(average.doubleValue)
    }

    func recorder(controller: MTRecorderController!, didFinishRecording fileURL: NSURL!, duration: NSNumber!, peaks peeks: [AnyObject]!) {
        
        recordButton.enabled = true
        recorder.reset()
        
        let audio = MTAudio()
        audio.mediaId = MTIdGenerator.sharedInstance().generateId()
        audio.audioPeaks = peeks
        audio.filePath = fileURL.path
        audio.duration = duration
        
        MTStorageService.sharedInstance.saveAudio(audio) { [weak weakSelf = self](error) in
            if error == nil {
                weakSelf?.playAudio(audio)
            }
        }
    }

}


class MTRecordViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView! {
        didSet {
            bgImageView.contentMode = .ScaleAspectFit
            bgImageView.image = UIImage(named: "bg")
        }
    }

    @IBOutlet weak var recordButton: MTRecordButton! {
        didSet {
            recordButton.addTarget(self, action: #selector(self.actionTouchDown(_:)), forControlEvents: .TouchDown)
            recordButton.addTarget(self, action: #selector(self.actionTouchUp(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.backgroundColor = UIColor.colorRGB(0x32, 0x32, 0x32, 0.1)
        }
        
    }
    @IBOutlet weak var graphView: PRCurrentPaceGraphView! {
        didSet {
            graphView.backgroundColor = UIColor.clearColor()
        }
    }
    
    lazy var recorder:MTRecorderController = {
        var recorder = MTRecorderController();
        recorder.delegate = self
        recorder.reset()
        
        return recorder
    }()
    
    deinit
    {
        // remove observer
        NSNotificationCenter.removeObserver(self, forKeyPath: UIApplicationWillEnterForegroundNotification)
    }
    
    //view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.colorRGB(0x32, 0x32, 0x32, 0.7)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.enterForeground(_:)), name: UIApplicationWillEnterForegroundNotification , object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        graphView.startAnimation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        graphView.stopAnimation()
    }
    
    func enterForeground(noti:NSNotification) {
        graphView .startAnimation()
    }
    
    func actionTouchDown(button:MTRecordButton) {
        recorder.start()
    }

    func actionTouchUp(button:MTRecordButton) {
        recorder.stop()
    }
    
    func playAudio(audio:MTAudio) -> Void {
        let playerVC = MTAudioPlayerViewController()
        playerVC.modalPresentationStyle = .OverFullScreen
        playerVC.audio = audio
        playerVC.onAudioPlayFinished = {[weak weakSelf = self]()->Void in
            weakSelf?.dismissViewControllerAnimated(false, completion: {
                weakSelf?.graphView .movePosition(0.0)
            })
        }
        
        
        self.presentViewController(playerVC, animated: false){}
            
    }
    
    
}
