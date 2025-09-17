//
//  UnderlinedButton.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/25/21.
//

import UIKit

class UnderlinedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 14, weight: .medium),
              .foregroundColor: AppColors.mainColor,
              .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: title ?? "", attributes: attributes)
        setAttributedTitle(attributeString, for: state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
