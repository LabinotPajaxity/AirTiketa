//
//  HomeInputView.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/27/21.
//

import UIKit

protocol SearchFlightsInputViewDelegate: AnyObject {
    func didTapOnInputView(_ inputView: HomeFormEntryView, type: SearchFlightsDataEntry)
    func didTapSwitchDirections(_ searchView: SearchFlightsInputView)
    func didTapSearch(_ searchView: SearchFlightsInputView)
    func didTapNewSearch(_ searchView: SearchFlightsInputView)
}

class SearchFlightsInputView: UIView {
    private let contentView: UIView = {
        let view = UIView.newAutoLayout()
        view.autoSetDimension(.height, toSize: 275)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()

    private lazy var switchDirectionsButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setImage(UIImage(named: "switch-directions"), for: .normal)
        button.addTarget(self, action: #selector(switchDirectionsButtonAction), for: .touchUpInside)
        button.autoSetDimensions(to: CGSize(width: 40, height: 40))
        return button
    }()
    
     lazy var searchButton: BlueButton = {
        let button = BlueButton.newAutoLayout()
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var newSearchButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.setTitle("New Search", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(AppColors.newRedColorForALL, for: .normal)
        button.addTarget(self, action: #selector(newSearchButtonAction), for: .touchUpInside)
        return button
    }()
    
    var inputViews = [SearchFlightsDataEntry: HomeFormEntryView]()

    weak var delegate: SearchFlightsInputViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        inputViews = SearchFlightsDataEntry.makeDataEntries()
        inputViews[.passengers]?.value = "1 Adult"
        
        
        backgroundColor = AppColors.almostWhite
        layer.cornerRadius = 10
        autoSetDimension(.height, toSize: 470)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func switchDirectionsButtonAction() {
        let toInputDataEntry = SearchFlightsDataEntry.to
        guard inputViews[toInputDataEntry]?.value != toInputDataEntry.placeholder else {
            return
        }
        let fromDestination = inputViews[.from]?.value
        inputViews[.from]?.value = inputViews[.to]?.value
        inputViews[.to]?.value = fromDestination
        delegate?.didTapSwitchDirections(self)
    }
    
    @objc private func searchButtonAction() {
        delegate?.didTapSearch(self)
    }
    
    @objc private func newSearchButtonAction() {
        inputViews.forEach {
            $1.value = $0.placeholder
        }
        delegate?.didTapNewSearch(self)
    }
    
    private func addSubviews() {
        [contentView, switchDirectionsButton, searchButton, newSearchButton].forEach(addSubview)
        inputViews.forEach { type, inputView in
            contentView.addSubview(inputView)
            inputView.tapHandler = { [weak self] in
                self?.delegate?.didTapOnInputView(inputView, type: type)
            }
        }
    }
    
    private func setupConstraints() {
        contentView.autoPinEdge(toSuperviewEdge: .top, withInset: 70)
        contentView.autoPinSidesSuperView()
        
        switchDirectionsButton.autoAlignAxis(toSuperviewAxis: .vertical)
        switchDirectionsButton.autoPinEdge(.top, to: .bottom, of: inputViews[.from]!, withOffset: -20)
        
        inputViews[.from]?.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        
        inputViews[.to]?.autoPinBelow(view: inputViews[.from]!)
        
        let stackView = UIStackView(arrangedSubviews: [inputViews[.departure]!, inputViews[.return]!])
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)
        stackView.autoPinBelow(view: inputViews[.to]!, right: 4)
        
        inputViews[.passengers]?.autoPinBelow(view: stackView)
        
        searchButton.autoPinBelow(view: contentView, top: 24, left: 25, right: 25)
        
        newSearchButton.autoPinEdge(.top, to: .bottom, of: searchButton, withOffset: 24)
        newSearchButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
}
