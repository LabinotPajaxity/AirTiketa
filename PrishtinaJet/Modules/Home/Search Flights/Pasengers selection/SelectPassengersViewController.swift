//
//  SelectPassengersViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/31/21.
//

import UIKit

protocol SelectPassengersViewControllerDelegate: AnyObject {
    func didSelectPassengers()
}

class SelectPassengersViewController: ModalViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView.newAutoLayout()
        stackView.spacing = 50
        stackView.axis = .vertical
        return stackView
    }()
    
    private var selectionViews: [PassengerSelectionType: PassengerSelectionView] = [:]
    weak var delegate: SelectPassengersViewControllerDelegate?
    
    let viewModel: SelectPassengersViewModel
    
    private var passengers: [Passenger] = []
    
    init(viewModel: SelectPassengersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Choose number of Passengers"
        shouldDisplayBottomView = true
        bottomView.delegate = self
    }
    
    @objc func chooseButtonAction() {
        print("Choose")
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        
        PassengerSelectionType.allCases.forEach { type in
            let selectionView: PassengerSelectionView!
            switch type {
            case .adult:
                let adultCount = getPassengerCountFor(.adult)
                selectionView = PassengerSelectionView(type: type, count: adultCount, max: 10, min: 1)
            case .child:
                let childCount = getPassengerCountFor(.child)
                selectionView = PassengerSelectionView(type: type, count: childCount, max: 10, min: 0)
            case .inf:
                let babyCount = getPassengerCountFor(.inf)
                selectionView = PassengerSelectionView(type: type, count: babyCount, max: 10, min: 0)
            }
            selectionView.delegate = self
            selectionViews[type] = selectionView
            stackView.addArrangedSubview(selectionView)
        }
        [stackView, bottomView].forEach(view.addSubview)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        stackView.autoPinBelow(view: topBarView, top: 80)
        
        bottomView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
    }
    
    private func makePassengerFor(count: Int, type: PassengerSelectionType) {
        var tmp = 0
        while (tmp < count) {
            tmp += 1
            let new = Passenger(name: nil, type: type)
            passengers.append(new)
        }
    }
    
    private func getPassengerCountFor(_ type: PassengerSelectionType) -> Int {
        if let passengers = viewModel.model.passengers {
            var count = 0
            for passenger in passengers {
                if passenger.type == type {
                    count += 1
                }
            }
            return count
        }
        return type == .adult ? 1 : 0
    }
}

extension SelectPassengersViewController: ModalBottomViewDelegate {
    func didtapOnChooseButton() {
        guard let adultCount = selectionViews[.adult]?.count,
              let childCount = selectionViews[.child]?.count,
              let babyCount = selectionViews[.inf]?.count else {
            return
        }

        makePassengerFor(count: adultCount, type: .adult)
        makePassengerFor(count: childCount, type: .child)
        makePassengerFor(count: babyCount, type: .inf)
        
        let getCountJustForAdultsAndChild = adultCount + childCount
        
        
        
        viewModel.model.passengers = passengers
        UserDefaults.standard.setCountOfPassanger(value: getCountJustForAdultsAndChild)

        delegate?.didSelectPassengers()
        dismiss(animated: true, completion: nil)
    }
}

//    max 10 adults
//    if 10 adults, 0 children
//    infants must be smaller than or equal to adults
//    adults plus children must equal to 10

extension SelectPassengersViewController: PassengersViewDelegate {
    func didChangePassangersCount() {
        guard let adultCount = selectionViews[.adult]?.count,
              let childCount = selectionViews[.child]?.count,
              let babyCount = selectionViews[.inf]?.count else {
            return
        }
        
        if adultCount + childCount == 10 {
            selectionViews[.adult]?.incrementButton.isEnabled = false
            selectionViews[.child]?.incrementButton.isEnabled = false
        } else {
            selectionViews[.adult]?.incrementButton.isEnabled = true
            selectionViews[.child]?.incrementButton.isEnabled = true
        }
        
        if babyCount == adultCount {
            selectionViews[.inf]?.incrementButton.isEnabled = false
        } else {
            selectionViews[.inf]?.incrementButton.isEnabled = true
        }
        
        if babyCount > adultCount {
            selectionViews[.inf]?.count = adultCount
            selectionViews[.inf]?.countLabel.text = "\(adultCount)"
            selectionViews[.inf]?.incrementButton.isEnabled = false
        }
    }
}
