//
//  SelectDepartureHeader.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 13.4.21.
//

import UIKit

class SelectDepartureHeaderView: UIView {
    private let textLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "All prices are per passenger and include taxes."
        label.textColor = AppColors.darkGray
        label.textAlignment = .center
        return label
    }()
    
    init(width: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: width, height: 50)
        super.init(frame: frame)
        addSubview(textLabel)
        textLabel.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

