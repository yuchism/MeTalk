//
//  MTPushButton.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 6. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

class MTPushButton: UIButton
{
    
    lazy var gradient = {
        return CAGradientLayer()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        gradient.frame = self.bounds
    }
    
    func startAnimation() -> Void {
    //    UIInterpolatingMotionEffect *shadowEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.shadowOffset" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

    
    }
    
    
    
    func initialize() {
        self.backgroundColor = UIColor.clearColor()
        self.layer.insertSublayer(gradient, atIndex: 0)
        gradient.frame = self.bounds
    }

    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                gradient.colors = [UIColor.colorRGB(0x55, 0x55, 0x55,0.15).CGColor,UIColor.colorRGB(0xff, 0x99, 0x99,0.15).CGColor]
            }
            else {
                gradient.colors = [UIColor.colorRGB(0x99, 0x99, 0x99,0.15).CGColor,UIColor.colorRGB(0x55, 0x55, 0x55,0.15).CGColor]
            }
            
        }
    }
}
