//
//  ContinueButtonView.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 13.4.21.
//

import UIKit

protocol ContinueButtonDelegate: AnyObject {
    func didTapContinueButton()
}

class ContinueButtonView: ShadowView {
    
    weak var delegate: ContinueButtonDelegate?
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.lightBlue
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.color = .white
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: topAnchor),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // vendos spinner brenda button
        continueButton.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor)
        ])
        
        continueButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        delegate?.didTapContinueButton()
    }
    
    // 🔹 Public API
    func showLoading(_ loading: Bool) {
        if loading {
            continueButton.setTitle("", for: .normal) // fsheh tekstin
            activityIndicator.startAnimating()
            continueButton.isEnabled = false
        } else {
            activityIndicator.stopAnimating()
            continueButton.setTitle("Confirm & Pay", for: .normal)
            continueButton.isEnabled = true
        }
    }
}
