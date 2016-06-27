//
//  MTAudioPlayerViewController.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 4. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//


import UIKit

@objc class MTAudioPlayerViewController: UIViewController {

    @IBOutlet weak var plotView: UCPlotView!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var lblEnd: UILabel!

    
    internal var onAudioPlayFinished:(()->Void)?
    internal var onAudioPlayStart:(()->Void)?
    
    lazy var player:MTAudioPlayer = {
        return MTAudioPlayer();
    }()

    private var _audio : MTAudio!;
    
    var audio:MTAudio? {
        set {
            _audio = newValue;
        }
        get {
            return _audio;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.colorRGB(0x99, 0x99, 0x99, 0.2);
        self.plotView.mode = UCPlotViewModeProgress
        self.plotView.progressColor = UIColor.colorRGB(0xAA, 0x44, 0x44)
        // Do any additional setup after loading the view.
        self.initPlayer();
        
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
