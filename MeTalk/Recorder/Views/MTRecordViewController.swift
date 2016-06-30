//
//  MTRecordViewController.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 6. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit


struct LocationInfo {
    var location:CLLocation
    var address:String
}


class MTLocationManager: NSObject,CLLocationManagerDelegate
{
    var isEnabled:Bool = false;
    var locManager:CLLocationManager!
    {
        didSet {
            locManager.delegate = self
            locManager.distanceFilter = 200
            
            let authorizationStatus = CLLocationManager.authorizationStatus()
            switch authorizationStatus {
            case .Authorized,.AuthorizedWhenInUse:
                isEnabled = true
                locManager.startUpdatingLocation()
            case .NotDetermined:
                isEnabled = false
                locManager.requestWhenInUseAuthorization()
            default:
                isEnabled = false
                break
            }
            
        }
    }
    
    var timer:NSTimer?
    
    
    var location:LocationInfo =
        LocationInfo(location: CLLocation(latitude:0,longitude:0), address: "")

    override init() {
        super.init()
        defer {
            self.locManager = CLLocationManager()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        if let loc = locations.first ?? locManager.location
        {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(loc){ (marks:[CLPlacemark]?, error:NSError?) in
//            self.location = LocationInfo(location: loc, address: <#T##String#>)
            
            
            }
        
        } else
        {
            
        }
        
        

        
//        self.location = LocationInfo(location:  ?? CLLocation(latitude: 0,longitude: 0), address: "")
    
    
    
    }

    func locationManager(manager: CLLocationManager , didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized,.AuthorizedWhenInUse:
            isEnabled = true
        default:
            isEnabled = false
            break
            
        }
    }

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }

    func requestLocation(complete:(LocationInfo)->Void)
    {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue())
        {[unowned self] in
            
            
            complete(self.location)
        }
    }
    
}




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

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error)
    }
    
    
    func recorder(controller: MTRecorderController!, didFinishRecording fileURL: NSURL!, duration: NSNumber!, peaks peeks: [AnyObject]!) {
        
        recordButton.enabled = true
        recorder.reset()
        
        let audio = MTAudio()
        
        audio.mediaId = MTIdGenerator.sharedInstance().generateId()
        audio.audioPeaks = peeks
        audio.filePath = fileURL.path
        audio.duration = duration
        
        locManager.requestLocation {[audio,weak self] (location:LocationInfo) in
            
            MTStorageService.sharedInstance.saveAudio(audio) { [weak weakSelf = self](error) in
                if error == nil {
                    weakSelf?.playAudio(audio)
                }
            }
        }
        
    }

}


class MTRecordViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView! {
        didSet {
            bgImageView.contentMode = .ScaleAspectFill
            bgImageView.image = UIImage(named: "bg")
            
            
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = -50
            horizontalMotionEffect.maximumRelativeValue = 50
            
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = -50
            verticalMotionEffect.maximumRelativeValue = 50
            
            let effectGroup = UIMotionEffectGroup()
            effectGroup.motionEffects = [horizontalMotionEffect,verticalMotionEffect]
            
            bgImageView.addMotionEffect(effectGroup)
            
            
        }
    }

    @IBOutlet weak var btnHistory: UIButton! {
        
        didSet {
            
            
            btnHistory.addTarget(self, action: #selector(self.actionHistory), forControlEvents:.TouchUpInside)
            
        }
    }
    
    var locManager = MTLocationManager();
    
    
    func actionHistory() -> Void {
        
        performSegueWithIdentifier("showHistory", sender: self);
    
    }
    
    
    
    @IBOutlet weak var recordButton: MTRecordButton! {
        didSet {
            recordButton.addTarget(self, action: #selector(self.actionTouchDown(_:)), forControlEvents: .TouchDown)
            recordButton.addTarget(self, action: #selector(self.actionTouchUp(_:)), forControlEvents: .TouchUpInside)
   
        }
    }
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.backgroundColor = UIColor.colorRGB(0x32, 0x32, 0x32, 0.5)
            
        }
        
    }
    @IBOutlet weak var graphView: PRCurrentPaceGraphView! {
        didSet {
            graphView.backgroundColor = UIColor.clearColor()
            graphView.on = false
            
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
        self.navigationController?.navigationBar.hidden = true

        self.view.backgroundColor = UIColor.colorRGB(0x32, 0x32, 0x32, 0.7)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.enterForeground(_:)), name: UIApplicationWillEnterForegroundNotification , object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        graphView.startAnimation()
        self.navigationController?.navigationBar.hidden = true

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        graphView.stopAnimation()
    }
        
    func enterForeground(noti:NSNotification) {
        graphView.startAnimation()
    }
    
    func actionTouchDown(button:MTRecordButton) {
        recorder.start()
        graphView.on = true
        
    }

    func actionTouchUp(button:MTRecordButton) {
        recorder.stop()
        graphView.on = false
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
