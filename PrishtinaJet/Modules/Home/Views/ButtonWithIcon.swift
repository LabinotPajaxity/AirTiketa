//
//  ButtonWithIcon.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/27/21.
//

import UIKit

class ButtonWithIcon: UIButton {
    private let iconImageView: UIImageView = {
        return UIImageView(image: UIImage(named: "right-chevron"))
    }()
    
    var icon: UIImage? {
        get { return iconImageView.image }
        set { iconImageView.image = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoSetDimension(.height, toSize: 30)
                
        contentHorizontalAlignment = .left
        isUserInteractionEnabled = false
        setTitle("Choose", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        setTitleColor(AppColors.almostBlack, for: .normal)
        
        addSubview(iconImageView)
        iconImageView.autoPinEdge(toSuperviewEdge: .trailing)
        iconImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ButtonWithIcon: InputViewType {
    var value: String? {
        get { return title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
}
