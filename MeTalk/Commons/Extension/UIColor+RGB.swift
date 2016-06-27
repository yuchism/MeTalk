//
//  UIColor+RGB.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 6. 27..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

import UIKit

extension UIColor
{
    static func colorRGB(red:Int, _ green:Int, _ blue:Int, _ alpha:Float) -> UIColor {
        
        let fRed = Float(red) / 255.0
        let fGreen = Float(green) / 255.0
        let fBlue = Float(blue) / 255.0
        
        return UIColor.init(colorLiteralRed: fRed, green: fGreen, blue: fBlue, alpha: alpha)
    }
    
    static func colorRGB(red:Int, _ green:Int, _ blue:Int) -> UIColor {
        return self .colorRGB(red, green, blue, 1.0);
    }
    
}