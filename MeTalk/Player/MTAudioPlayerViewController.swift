//
//  MTAudioPlayerViewController.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 4. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//


import UIKit

@objc class MTAudioPlayerViewController: UIViewController {

    @IBOutlet weak var plotView: UCPlotView! {
        didSet {
            plotView.mode = UCPlotViewModeProgress
            plotView.progressColor = UIColor.colorRGB(0xFF, 0x88, 0x88)
            plotView.plotBGColor = UIColor.colorRGB(0x44, 0x44, 0x44)
            
            plotView.bgView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var lblProgress: UILabel!  {
        didSet {
            lblProgress.textColor = UIColor.colorRGB(0xAA, 0xAA, 0xAA)
        }
    }
    @IBOutlet weak var lblEnd: UILabel! {
        
        didSet {
            lblEnd.textColor = UIColor.colorRGB(0xAA, 0xAA, 0xAA)
        }
    }
    
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 10
        }
    }

    
    internal var onAudioPlayFinished:(()->Void)?
    internal var onAudioPlayStart:(()->Void)?
    
    lazy var player:MTAudioPlayer = {
        return MTAudioPlayer();
    }()

    var audio:MTAudio? {
        set {
            _audio = newValue;
        }
        get {
            return _audio;
        }
    }
    
    private var _audio:MTAudio?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.frame = self.view.bounds;
        visualEffectView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        self.view.insertSubview(visualEffectView, atIndex: 0)
        

        let gr = UITapGestureRecognizer(target: self, action: #selector(self.actionTap(_:)))
        view .addGestureRecognizer(gr)
        
        
        // Do any additional setup after loading the view.
        self.initPlayer();
    }

    func actionTap(gr:UITapGestureRecognizer) -> Void {
        self.player.stop()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    private func initPlayer()
    {
        let filePath:String = self.audio!.filePath as String;
        let audioData:NSData? =  NSData(contentsOfFile:filePath)
        
        
        self.player.play(audioData!);
        self.plotView.setPeeks(self.audio?.audioPeaks);
        self.lblEnd.text = MTUtils.durationToString(CGFloat((self.player.duration()) ?? 0))
                
        player.onAudioStart = { [unowned self] () -> Void in
            
            if self.onAudioPlayStart != nil {
                self.onAudioPlayStart!()
            }
        }
        
        player.onAudioProgress = { [unowned self] (duration:Double?,current:Double?) -> Void in

            let progress:Double = current!/duration!;
            
            self.lblProgress.text = MTUtils.durationToString(CGFloat(current ?? 0))
            self.plotView.progress = CGFloat(progress);
            
        };

        player.onAudioFinish = { [unowned self] () -> Void in
            
            if self.onAudioPlayFinished != nil {
                self.onAudioPlayFinished!()
            }
        }
    }

}
