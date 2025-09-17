//
//  ModalViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/23/21.
//

import UIKit

class ModalViewController: UIViewController {
    
    let topBarView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = AppColors.newRedColorForALL
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setImage(UIImage(named: "close-white"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let topBarStackView: UIStackView = {
        let stackView = UIStackView.newAutoLayout()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    let bottomView: ModalBottomView = {
        let view = ModalBottomView.newAutoLayout()
        return view
    }()
    
    var shouldDisplayBottomView = false
    
    // Keep a height constraint reference so we can update after knowing safeAreaInsets
    private var topBarHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update height to include safe area inset at the top
        let topInset = view.safeAreaInsets.top
        topBarHeightConstraint?.constant = 60 + topInset
        
        // Also update stack view top padding so content is below notch
        if let stackViewSuperview = topBarStackView.superview {
            topBarStackView.autoPinEdge(.top, to: .top, of: stackViewSuperview, withOffset: topInset)
        }
    }
    
    @objc func closeButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func addSubviews() {
        var viewsToAdd = [topBarView]
        if shouldDisplayBottomView {
            viewsToAdd.append(bottomView)
        }
        viewsToAdd.forEach(view.addSubview)
        
        [closeButton, titleLabel].forEach(topBarStackView.addArrangedSubview)
        
        topBarView.addSubview(topBarStackView)
    }
    
    func setupConstraints() {
        // Pin to very top (superview) so it covers status bar area
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Height will be updated later when safeAreaInsets are known
        topBarHeightConstraint = topBarView.heightAnchor.constraint(equalToConstant: 60)
        topBarHeightConstraint?.isActive = true
        
        topBarStackView.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        topBarStackView.autoPinEdge(toSuperviewEdge: .right)
        // top pin is handled in viewDidLayoutSubviews
        
        if shouldDisplayBottomView {
            bottomView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        }
    }
}
