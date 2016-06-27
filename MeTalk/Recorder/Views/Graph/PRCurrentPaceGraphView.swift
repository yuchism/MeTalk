//
//  PRCurrentPaceGraphView.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 1..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class PRCurrentPaceGraphView: UIView {
    
    lazy var baseLayer:CAGradientLayer = {
        return CAGradientLayer()
    }()

    lazy var shadow1:CALayer = {
        return CALayer()
    }()
    
    lazy var shadow2:CALayer = {
        return CALayer()
    }()

    lazy var shadow3:CALayer = {
        return CALayer()
    }()
    
    
    @IBInspectable var targetPoint:CGPoint
    @IBInspectable var value:Double
    
    lazy var shadows:Array<CALayer> = {
        return Array<CALayer>();
    }()
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    override init(frame: CGRect) {
        self.targetPoint = CGPointZero;
        self.value = 0.0
        
        super.init(frame: frame)

        self.initialize();

    }
    
    required init(coder aDecoder: NSCoder) {
        self.targetPoint = CGPointZero;
        self.value = 0.0

        super.init(coder: aDecoder)!

        self.initialize();
    }
    
    private func initialize() -> Void {
        self.targetPoint = (self.baseLayer.valueForKey("position")?.CGPointValue())!
        self.createLayers()
        
        self.startAnimation()
    }
    
    private func centerPoint() -> CGPoint {
    
        let point = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) * 10/8)
        return point
    }
    
    

    private func createLayers() -> Void {

        self.baseLayer.backgroundColor = UIColor.init(red: 0xff, green: 0x00, blue: 0x00, alpha: 0.25).CGColor
        
        self.shadow1.backgroundColor = UIColor.init(red: 0xff, green: 0x00, blue: 0x00, alpha: 0.15).CGColor;
        self.shadow2.backgroundColor = UIColor.init(red: 0xff, green: 0x00, blue: 0x00, alpha: 0.15).CGColor;
        self.shadow3.backgroundColor = UIColor.init(red: 0xff, green: 0x00, blue: 0x00, alpha: 0.15).CGColor;
        
        self.layer.addSublayer(self.shadow3)
        self.layer.addSublayer(self.shadow2)
        self.layer.addSublayer(self.shadow1)
        self.layer.addSublayer(self.baseLayer)
        
        
        self.shadows.append(self.baseLayer)
        self.shadows.append(self.shadow1)
        self.shadows.append(self.shadow2)
        self.shadows.append(self.shadow3)
        
    }

    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        self.relocateLayer()

    }

    override func setNeedsUpdateConstraints() {
        super.setNeedsUpdateConstraints()
        self.relocateLayer()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        self.relocateLayer()
    }
    
    private func relocateLayer() -> Void {
        
        CATransaction.begin()
        
        self.stopAnimation()
    
        self.targetPoint = (self.baseLayer.valueForKey("position")?.CGPointValue())!
        
        self.baseLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.shadow1.frame =  CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.shadow2.frame =  CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.shadow3.frame =  CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));

        self.baseLayer.position = self.centerPoint()
        self.shadow1.position = self.centerPoint()
        self.shadow2.position = self.centerPoint()
        self.shadow3.position = self.centerPoint()

        self.startAnimation()
        
        CATransaction.commit()
        
    }
    
    
    func movePosition(value:Double) -> Void {
        self.value = value

        let height = CGRectGetHeight(self.bounds)
        
        var pointY:CGFloat = self.centerPoint().y - (CGFloat(value) * CGRectGetHeight(self.bounds) / 5)
        
        if pointY > (height * 3/2) {
            pointY = height * 3/2
        }
        if pointY < -(height / 2) {
            pointY = -1 * (height / 2)
        }
        
        self.targetPoint = CGPointMake(self.centerPoint().x, pointY)
    }
    
    
    
    func startAnimation() -> Void {
        self.waveUpAni()
    }
    
    func stopAnimation() -> Void {
        
        self.baseLayer.removeAllAnimations()
        self.shadow1.removeAllAnimations()
        self.shadow2.removeAllAnimations()
        self.shadow3.removeAllAnimations()
        
    }
    
    func waveUpAni() -> Void {
        CATransaction.begin()
        for (index,layer) in self.shadows.enumerate() {
            self.waveAni("waveup", layer: layer, idx: index)
        }
        CATransaction.commit()
    }
    
    func waveDownAni() -> Void {
        CATransaction.begin()
        for (index,layer) in self.shadows.enumerate() {
            self.waveAni("wavedown", layer: layer, idx: index)
        }
        CATransaction.commit()
    }
    
    func waveAni(name:String,layer:CALayer,idx:Int) {

        let timeOffset:Double = Double(idx) * 0.2
        var defaultOffset:CGFloat = CGFloat(idx) * CGFloat(self.value) + 10.0
        
        if name == "waveup" {
            defaultOffset = defaultOffset * (-1.0)
        }
        
        let newPoint:CGPoint = CGPointMake(self.targetPoint.x, targetPoint.y + defaultOffset)
        
        let wave:CABasicAnimation = CABasicAnimation.init(keyPath: "position")
        wave.delegate = self
        wave.removedOnCompletion = true
        wave.repeatCount = 1
        wave.autoreverses = false
        wave.duration  = 1.0
        wave.fromValue = layer.valueForKey("position")
        wave.toValue = NSValue.init(CGPoint: newPoint)
        
        wave.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        wave.setValue(name, forKey: "animationName")
        wave.setValue(idx, forKey: "layerIdx")
        wave.setValue(NSStringFromCGPoint(newPoint), forKey: "newPoint")
        
        wave.beginTime = self.baseLayer.convertTime(CACurrentMediaTime(), fromLayer: nil) + timeOffset
        layer.addAnimation(wave, forKey:name)
        

    }
    
    override func animationDidStart(anim: CAAnimation) {
        let layer:CALayer = self.shadows[(anim .valueForKey("layerIdx")?.integerValue)!]
        let newPoint:CGPoint = CGPointFromString(anim.valueForKey("newPoint") as! String);
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        layer.position = newPoint
        CATransaction.commit()
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {

        let aniName:String = anim .valueForKey("animationName") as! String
        let layerIdx:Int = (anim.valueForKey("layerIdx")?.integerValue)!
        
        let layer:CALayer = self.shadows[layerIdx]
        if aniName == "waveup" && flag {
            self.waveAni("wavedown", layer: layer, idx: layerIdx)
        } else if aniName == "wavedown" && flag {
            self.waveAni("waveup", layer: layer, idx: layerIdx)
        }
        
        
    }

}
