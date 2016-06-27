//
//  PRActivityStartButton.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 11..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

class PRActivityStartButton: UIView {

    var isOn:Bool =  false {
        didSet {
            if isOn {
                self.buttonOn()
            } else {
                self.buttonOff()
            }
            
        }
    }
  
    private var longGr:UILongPressGestureRecognizer?
    private var tapGr:UITapGestureRecognizer?
    private var imageView:UIImageView?
    private var baseLayer:CAShapeLayer?
    
    private var counter:Int = 0
    private var isLongPressSuccess:Bool = false
    private var timer:NSTimer?
    
    
    var delegate:PRActivityStartButtonDelegate?
    
    deinit {
        self.delegate = nil
    }
    
    private func initialize() -> Void {
    
        longGr = UILongPressGestureRecognizer.init(target: self, action:#selector(self.actionLongPress(_:)))
        longGr?.minimumPressDuration = 0.0
        tapGr = UITapGestureRecognizer.init(target: self, action: Selector(actionTap()))
        
        imageView = UIImageView(image: UIImage(named: "start_icon"))
        imageView!.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
        imageView?.userInteractionEnabled = false
        
        self.backgroundColor = UIColor.clearColor()
        self.opaque = false
        self.addSubview(imageView!)
        
        self.createLayer()
        
        self.isOn = false
    }
    
    
    
    @objc private func actionLongPress(gesture:UILongPressGestureRecognizer) -> Void {
        if gesture.state == .Began {
            self.counter = 0;
            self.timer = NSTimer(timeInterval:0.01 , target:self, selector:Selector(incrementCounter()), userInfo: nil, repeats: true)
            
            isLongPressSuccess = false;
        }
    }
    
    private func actionTap() -> Void {
        
    }
    
    private func incrementCounter() -> Void {
        self.counter += 1
        self.relocateLayer()
    }
    
    private func buttonOn() -> Void {

        self.imageView?.image = UIImage(named: "pause_icon")
        self.removeGestureRecognizer(self.longGr!)
        self.removeGestureRecognizer(self.tapGr!)
        
        self.addGestureRecognizer(self.longGr!)
    }
    
    private func buttonOff() -> Void {
        self.imageView?.image = UIImage(named: "start_icon")
        self.removeGestureRecognizer(self.longGr!)
        self.removeGestureRecognizer(self.tapGr!)
        
        self.addGestureRecognizer(self.tapGr!)
        
    }
    
    private func createLayer() -> Void {
        baseLayer = CAShapeLayer()
        baseLayer?.fillColor = UIColor.colorRGB(0xff, 0xff, 0xff,0.75).CGColor
        
        self.layer.addSublayer(baseLayer!)
    
    }
    
    private func relocateLayer() -> Void {

        let center:CGPoint = CGPointMake(CGRectGetWidth(self.roundRect()) / 2 + 2, CGRectGetHeight(self.roundRect())/2 + 2)
        let percent:Int = counter * 24
        
        if percent <= 360 {
            
            let delta:CGFloat = self.degreesToRadians(CGFloat(percent))
            let innerRadius:CGFloat = 36.5
            let outerRadius:CGFloat = innerRadius + 13
            
            let path:CGMutablePathRef = CGPathCreateMutable()
            CGPathAddRelativeArc(path, nil, center.x, center.y, innerRadius, -1 * (CGFloat(M_PI) / 2), delta);
            CGPathAddRelativeArc(path, nil, center.x, center.y, outerRadius, delta - (CGFloat(M_PI) / 2), -delta);
            CGPathAddLineToPoint(path, nil, center.x, center.y-innerRadius);

            baseLayer?.path = path
            
        } else {
            isLongPressSuccess = true
            self.longPressDone();
        }
    }
    
    private func longPressDone() -> Void {
//
//        if([self.delegate respondsToSelector:@selector(activityStartButtonActionStop:)] && _isLongPressSucceed == YES)
//        {
//            [self.delegate activityStartButtonActionStop:self];
//        }
//        
//        [self.timer invalidate];
//        self.timer = nil;
//        self.counter = 0;
//        _isLongPressSucceed = NO;
//        [self _repositionLayer];
//        
        
        
    }
    
    
    private func degreesToRadians(degrees:CGFloat) -> CGFloat {

        return degrees * CGFloat(M_PI) / 180;
    }
    
    private func roundRect() -> CGRect {
        let margin:CGFloat = 2;
        let rect:CGRect = CGRectMake(margin,margin,CGRectGetWidth(self.bounds) - margin * 2,CGRectGetHeight(self.bounds) - margin * 2);
        
        return rect;
    }
    
    override func drawRect(rect: CGRect) {
        
        let contextRef:CGContextRef = UIGraphicsGetCurrentContext()!;
        
        CGContextSetRGBFillColor(contextRef, 0x00, 0x00, 0x00, 1.0);
        CGContextSetRGBStrokeColor(contextRef, 0x00, 0x00, 0x00, 1.0);
        
        CGContextFillEllipseInRect(contextRef, self.roundRect());
        CGContextStrokeEllipseInRect(contextRef, self.roundRect());
    }

}
