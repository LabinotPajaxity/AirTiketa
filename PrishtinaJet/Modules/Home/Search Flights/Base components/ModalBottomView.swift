//
//  ModalBottomView.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 4/2/21.
//

import UIKit

protocol ModalBottomViewDelegate: AnyObject {
    func didtapOnChooseButton()
}

class ModalBottomView: UIView {
    let statusLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let chooseButton: BlueButton = {
        let button = BlueButton.newAutoLayout()
        button.setTitle("Choose", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.heightConstraint?.constant = 50
        button.layer.cornerRadius = 10
        button.autoSetDimension(.width, toSize: 120)
        button.addTarget(self, action: #selector(chooseButtonAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ModalBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -3)
        autoSetDimension(.height, toSize: 100)
        backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [statusLabel, chooseButton].forEach(addSubview)
    }
    
    private func setupConstraints() {
        chooseButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)
        chooseButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        
        statusLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 24)
        statusLabel.autoAlignAxis(.horizontal, toSameAxisOf: chooseButton)
    }
    
    @objc func chooseButtonAction() {
        delegate?.didtapOnChooseButton()
    }
}
