//
//  SelectDepartureTopView.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 9.4.21.
//

import UIKit

class SelectDepartureTopView: UIStackView {
    private let planeImageView: UIImageView = {
        let image = UIImage(named: "plane")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var fromLabel: UILabel = {
        return makeTitleLabel()
    }()
    
    private lazy var toLabel: UILabel = {
        return makeTitleLabel()
    }()
    
    var departure: String? {
        didSet {
            fromLabel.text = departure
        }
    }
    
    var arrival: String? {
        didSet {
            toLabel.text = arrival
        }
    }
       
    override init(frame: CGRect) {
        super.init(frame: .zero)
        autoSetDimension(.height, toSize: 100)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        axis = .horizontal
        spacing = 10
        backgroundColor = AppColors.newRedColorForALL
        distribution = .fillProportionally
        
        [fromLabel, planeImageView, toLabel].forEach(addArrangedSubview)
        planeImageView.translatesAutoresizingMaskIntoConstraints = false
        planeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        planeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        planeImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        planeImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel.newAutoLayout()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}
