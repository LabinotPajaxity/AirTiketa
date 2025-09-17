//
//  CheckBox.swift
//  PronaIme
//
//  Created by Pajaziti Labinot on 13.7.21..
//

import UIKit

class CheckBox: UIButton {
    // Images
    private let checkedImage = UIImage(systemName: "checkmark.circle.fill")!
    private let uncheckedImage = UIImage(systemName: "checkmark.circle")!
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            self.setImage(isChecked ? checkedImage : uncheckedImage, for: .normal)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.isChecked = false
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    // MARK: - Toggle
    @objc private func buttonClicked() {
        isChecked.toggle()
    }
}
