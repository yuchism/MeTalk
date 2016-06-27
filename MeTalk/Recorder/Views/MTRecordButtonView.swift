//
//  MTRecordButtonView.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 11..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

@IBDesignable
class MTRecordButtonView: UIView {

    @IBOutlet weak var recordButton: MTRecordButton!
    @IBOutlet weak var plotView: UCPlotView!
    
//private outlet
    @IBOutlet weak private var bgView: UIView!
    
    override func awakeFromNib() {
        self.initialize()
    }
    
    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
       
        if self.subviews.count == 0 {
            let view:MTRecordButtonView = self.loadNib()
            view.frame = self.frame
            view.autoresizingMask = self.autoresizingMask
        
            view.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints
            for  constraint:NSLayoutConstraint in self.constraints {
                var firstItem = constraint.firstItem
                if(firstItem === self) {
                    firstItem = view
                }
                var secondItem = constraint.secondItem
                if(secondItem === self) {
                    secondItem = self
                }
                view.addConstraint(NSLayoutConstraint(item: firstItem, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
                
            }
            
            return view
        }
        
        return self
    }

    func loadNib() -> MTRecordButtonView {
        return NSBundle.init(forClass:object_getClass(self)) .loadNibNamed("MTRecordButtonView", owner: nil, options: nil)[0] as! MTRecordButtonView
    
    }
    
    private func initialize() -> Void {
        self.plotView.mode = UCPlotViewModeMetering;
        self.plotView.backgroundColor = UIColor.clearColor()
        self.bgView.backgroundColor = UIColor.init(red: 0x11, green: 0x11, blue: 0x11, alpha: 0.1)
        self.bgView.backgroundColor = UIColor.redColor()
        self.backgroundColor = UIColor.clearColor()
    }

 
}
