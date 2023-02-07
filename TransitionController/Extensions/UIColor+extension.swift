//
//  UIColor+Extension.swift
//  TransitionController
//
//  Created by Roman Bigun on 11.08.2022.
//

import UIKit

extension UIColor {
    
    /// Returns Red value from color in RGB color scheme in a range of 0-255
    var redValue: CGFloat {
        return CIColor(color: self).red * 255.0
    }
    
    /// Returns Green value from color in RGB color scheme in a range of 0-255
    var greenValue: CGFloat {
        return CIColor(color: self).green * 255.0
    }
    
    /// Returns Blue value from color in RGB color scheme in a range of 0-255
    var blueValue: CGFloat {
        return CIColor(color: self).blue * 255.0
    }
    
    /// Returns Alpha value from color in RGB color scheme in a range of 0-255
    var alphaValue: CGFloat {
        return CIColor(color: self).alpha
    }
    
    
    
    convenience init(hexString: String) {
        var string = hexString
        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }
        let scanner = Scanner(string: string)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }
    
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgb: Int = (Int) (red * 255) << 16 | (Int) (green * 255) << 8 | (Int) (blue * 255) << 0
        let hexColor: String = NSString(format: "#%06x", rgb) as String
        return hexColor
    }
}
