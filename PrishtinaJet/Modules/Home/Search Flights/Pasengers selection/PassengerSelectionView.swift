//
//  PassengerSelectionView.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/31/21.
//

import UIKit

protocol PassengersViewDelegate: AnyObject {
    func didChangePassangersCount()
}

class PassengerSelectionView: UIView {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.image = UIImage(named: selectionType.iconName)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "veryDarkBlue")
        label.text = selectionType.title
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "darkBlue")
        label.text = selectionType.subtitle
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView.newAutoLayout()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()

    lazy var decrementButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setImage(UIImage(named: "subtract")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = AppColors.newRedColorForALL
        button.isEnabled = count > selectionType.minimumValue
        button.addTarget(self, action: #selector(decrementButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var countLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: "veryDarkBlue")
        label.text = "\(count)"
        label.textAlignment = .center
        label.autoSetDimensions(to: CGSize(width: 80, height: 35))
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()


    lazy var incrementButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = AppColors.newRedColorForALL
        button.addTarget(self, action: #selector(incrementButtonAction), for: .touchUpInside)
        button.isEnabled = count < selectionType.maximumValue
        return button
    }()

  
    weak var delegate : PassengersViewDelegate?
    var count: Int
    
    var max: Int
    var min: Int
    
    lazy var searchFlightModel = SearchFlightModel()
    let selectionType: PassengerSelectionType
    
    init(type: PassengerSelectionType, count: Int, max: Int, min: Int) {
        self.count = count
        self.selectionType = type
        self.max = max
        self.min = min
        super.init(frame: .zero)
        
        autoSetDimension(.height, toSize: 50)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func decrementButtonAction() {
        count -= 1
        countLabel.text = "\(count)"
        decrementButton.isEnabled = count > min
        delegate?.didChangePassangersCount()
    }
    
//    max 10 adults
//    if 10 adults, 0 children
//    infants must be smaller than or equal to adults
//    adults plus children must equal to 10
    
    @objc func incrementButtonAction() {
        count += 1
        countLabel.text = "\(count)"
        decrementButton.isEnabled = count < max
        delegate?.didChangePassangersCount()
    }
    
    private func addSubviews() {
        [titleLabel, subtitleLabel].forEach(labelsStackView.addArrangedSubview)
        
        [
            iconImageView,
            labelsStackView,
            decrementButton,
            countLabel,
            incrementButton
        ]
        .forEach(addSubview)
    }
    
    private func setupConstraints() {
        [
            iconImageView,
            labelsStackView,
            decrementButton,
            countLabel,
            incrementButton
        ]
        .forEach { $0.autoAlignAxis(toSuperviewAxis: .horizontal) }
        
        iconImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 24)
        labelsStackView.autoPinEdge(.leading, to: .trailing, of: iconImageView, withOffset: 16)
        
        incrementButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)
        countLabel.autoPinEdge(.trailing, to: .leading, of: incrementButton, withOffset: -8)
        decrementButton.autoPinEdge(.trailing, to: .leading, of: countLabel, withOffset: -8)
    }
    
}
