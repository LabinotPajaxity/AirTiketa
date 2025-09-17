//
//  SelectDepartureDateView.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 12.4.21.
//

import UIKit

protocol SelectDepartureDateViewDelegate: AnyObject {
    func didTapOnNext()
    func didTapOnPrevious()
}

class SelectDepartureDateView: UIView {
    let leftArrowButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setImage(UIImage(named: "blue-left-chevron"), for: .normal)
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = AppColors.darkBlueForLabel
        label.textAlignment = .center
        return label
    }()
    
    let rightArrowButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setImage(UIImage(named: "blue-right-chevron"), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: SelectDepartureDateViewDelegate?
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        autoSetDimension(.height, toSize: 48)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [leftArrowButton, dateLabel, rightArrowButton].forEach(addSubview)
    }
    
    private func setupConstraints() {
        leftArrowButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        leftArrowButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        dateLabel.autoCenterInSuperview()
        
        rightArrowButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        rightArrowButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapOnNext()
    }
    
    @objc private func previousButtonTapped() {
        delegate?.didTapOnPrevious()
    }
}
