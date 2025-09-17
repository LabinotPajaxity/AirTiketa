//
//  ListInputButton.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/26/21.
//

import UIKit

class ListInputButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        layer.cornerRadius = 4
        layer.borderColor = AppColors.gray.cgColor
        autoSetDimension(.height, toSize: 42)
                
        contentHorizontalAlignment = .left
        setTitle("Choose", for: .normal)
        setTitleColor(.systemGray3, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        let imageView = UIImageView(image: UIImage(named: "right-chevron"))
        addSubview(imageView)
        imageView.autoPinEdge(toSuperviewMargin: .trailing)
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        addTarget(self, action: #selector(actionHandler), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionHandler() {
        UIView.animate(withDuration: 0.3) {
            self.layer.borderColor = AppColors.blue.cgColor
        }
    }

}

extension ListInputButton: InputViewType {
    var value: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
}
