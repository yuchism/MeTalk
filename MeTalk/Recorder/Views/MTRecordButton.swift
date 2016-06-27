//
//  MTRecordButton.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 11..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

class MTRecordButton: UIButton {

    override var highlighted: Bool {
        didSet {
            self.alpha = (self.highlighted) ? 0.5 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.initialize()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    
    private func initialize() -> Void {
        self.layer.borderColor = UIColor.blackColor().CGColor;
        self.layer.backgroundColor = UIColor.colorRGB(0x44, 0x66, 0x77).CGColor;
        
        self.setImage(UIImage(named:"audioBtnRecording"), forState: .Normal)
        
        self.resizeFrame()
    }
    
    private func resizeFrame() -> Void {
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2
    }
    
    
}
