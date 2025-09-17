//
//  UIViewController+BackgroundImage.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/9/21.
//

import Foundation
import UIKit

extension UIViewController {
    func addBackgroundImage() {
        let imageView = UIImageView.newAutoLayout()
        imageView.image = UIImage(named: "background")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        let overlayView = UIView.newAutoLayout()
        imageView.addSubview(overlayView)
        overlayView.autoPinEdgesToSuperviewEdges()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.46)
        
        view.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
    }
}
