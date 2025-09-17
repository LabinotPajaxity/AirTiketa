//
//  DateSelectionHeader.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/23/21.
//

import UIKit

protocol DateSelectionHeaderDelegate: AnyObject {
    func didSelectHeader(isArrival: Bool)
}

class DateSelectionHeader: UIView {
    
    private lazy var departureTitleLabel: UILabel = {
        return makeLabel(title: "Departure", textColor: AppColors.newRedColorForALL)
    }()
    
    private lazy var returnTitleLabel: UILabel = {
        return makeLabel(title: "Return", textColor: AppColors.newRedColorForALL)
    }()
    
    private lazy var departureDateLabel: UILabel = {
        return makeLabel(title: "Select Date", textColor: AppColors.newRedColorForALL)
    }()
    
    private lazy var returnDateLabel: UILabel = {
        return makeLabel(title: "Select Date", textColor: AppColors.newRedColorForALL)
    }()
    
    private lazy var firstStackView: UIStackView = {
        let stackView = makeStackView(titleLabel: departureTitleLabel, label: departureDateLabel)
        return stackView
    }()
    
    private lazy var secondStackView: UIStackView = {
        return makeStackView(titleLabel: returnTitleLabel, label: returnDateLabel)
    }()
    
    var isDepartureSelected = true
    var isReturnFlightSelected = false
    weak var delegate: DateSelectionHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = AppColors.darkBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
        autoSetDimension(.height, toSize: 72)
        
        let firstStackViewTap = UITapGestureRecognizer(target: self, action: #selector(firstStackViewTapped))
        firstStackView.addGestureRecognizer(firstStackViewTap)
        
        let secondStackViewTap = UITapGestureRecognizer(target: self, action: #selector(secondStackViewTapped))
        secondStackView.addGestureRecognizer(secondStackViewTap)
        
        [firstStackView, secondStackView].forEach(addSubview)
        
        firstStackView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .trailing)
        firstStackView.autoMatch(.width, to: .width, of: self, withMultiplier: 0.5)
        
        secondStackView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .leading)
        secondStackView.autoMatch(.width, to: .width, of: self, withMultiplier: 0.5)
        
        setViewActive(isFirst: true) // Initial state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLabel(title: String, textColor: UIColor = .white) -> UILabel {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = title
        label.textColor = textColor
        return label
    }
    
    private func makeStackView(titleLabel: UILabel, label: UILabel) -> UIStackView {
        let stackView = UIStackView.newAutoLayout()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        [titleLabel, label].forEach(stackView.addArrangedSubview)
        return stackView
    }
    
    @objc
    private func firstStackViewTapped() {
        setViewActive(isFirst: true)
        delegate?.didSelectHeader(isArrival: false)
    }
    
    @objc
    private func secondStackViewTapped() {
        setViewActive(isFirst: false)
        delegate?.didSelectHeader(isArrival: true)
    }
    
    func setViewActive(isFirst: Bool) {
        isDepartureSelected = isFirst
        
        // Background colors (Red if selected, White if not)
        firstStackView.backgroundColor = isFirst ? AppColors.newRedColorForALL : .white
        secondStackView.backgroundColor = isFirst ? .white : AppColors.newRedColorForALL
        
        // Text colors — white if selected, red if not
        departureTitleLabel.textColor = isFirst ? .white : AppColors.newRedColorForALL
        departureDateLabel.textColor = isFirst ? .white : AppColors.newRedColorForALL
        
        returnTitleLabel.textColor = isFirst ? AppColors.newRedColorForALL : .white
        returnDateLabel.textColor = isFirst ? AppColors.newRedColorForALL : .white
    }

}
