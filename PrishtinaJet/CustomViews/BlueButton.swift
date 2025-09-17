//
//  BlueButton.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/25/21.
//

import UIKit

class BlueButton: UIButton {
    var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        setTitleColor(AppColors.lightGray, for: .disabled)
        backgroundColor = AppColors.newRedColorForALL
        heightConstraint = autoSetDimension(.height, toSize: 42)
        layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
