//
//  UIView+ShadowBorder.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 19.4.21.
//

import UIKit

class ShadowView: UIView {
    var radius: CGFloat = 0
    
    var isOnlyTopShadow = false
    
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: 20)
        self.layer.shadowPath = UIBezierPath(roundedRect: isOnlyTopShadow ?
                                                rect : self.bounds,
                                             byRoundingCorners: .allCorners,
                                             cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addShadowBorder(radius: CGFloat) {
        self.radius = radius
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = radius
    }
}
