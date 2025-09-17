//
//  Colors.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/23/21.
//

import UIKit

extension UIColor {
    static func rgb(red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0,
                       green: CGFloat(green)/255.0,
                       blue: CGFloat(blue)/255.0,
                       alpha: CGFloat(alpha))
    }
}

struct AppColors {
    static let mainColor            = UIColor.rgb(red: 6, green: 168, blue: 184, alpha: 1)
    static let almostWhite          = UIColor.rgb(red: 247, green: 247, blue: 249, alpha: 1)
    static let almostBlack          = UIColor(red: 0.214, green: 0.276, blue: 0.396, alpha: 1)
    static let orange               = UIColor(red: 1, green: 0.404, blue: 0.118, alpha: 1)
    static let darkBlue             = UIColor.rgb(red: 13, green: 59, blue: 102, alpha: 1)
    static let blue                 = UIColor(red: 0.118, green: 0.576, blue: 1, alpha: 1)
    static let lightBlue =          UIColor.rgb(red: 219, green: 0, blue: 1, alpha: 1)
    static let veryLightBlue        = UIColor(red: 0.953, green: 0.98, blue: 0.984, alpha: 1)
    static let blueSelected         = UIColor.rgb(red: 25, green: 122, blue: 192, alpha: 1)
    static let lightBlueSelected    = UIColor.rgb(red: 140, green: 188, blue: 225, alpha: 1)
    static let purple               = UIColor(red: 0.214, green: 0.276, blue: 0.396, alpha: 1)
    static let navColor             = UIColor(red: 0.051, green: 0.231, blue: 0.4, alpha: 1)
    static let gray                 = UIColor(red: 0.842, green: 0.855, blue: 0.875, alpha: 1)
    static let lightGray            = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    static let darkGray             = UIColor(red: 0.137, green: 0.196, blue: 0.31, alpha: 0.5)
    static let darkBlueForLabel     = UIColor.rgb(red: 55, green: 70, blue: 101, alpha: 1)
    static let newRedColorForALL =    UIColor.rgb(red: 219, green: 0, blue: 1, alpha: 1)
}

