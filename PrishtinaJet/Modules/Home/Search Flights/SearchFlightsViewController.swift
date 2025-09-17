//
//  ViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 1/15/21.
//

import UIKit
import PureLayout
import Toast

class SearchFlightsViewController: UIViewController {
    private let mainLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.numberOfLines = 2
        label.text = "Book your flight"
        label.autoSetDimension(.width, toSize: 190)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()
    private let stackView = UIStackView()
    
    private let returnButtonOutlet = UIButton()
    private var oneWayButtonOutlet = UIButton()
    private var passengers: [Passenger] = []
    
    
    private lazy var contentView: SearchFlightsInputView = {
        let view = SearchFlightsInputView.newAutoLayout()
        view.delegate = self
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var searchFlightModel = SearchFlightModel()
    
    var toggle = false
    var showOnlyReturnDateFlight = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Keep your toggle storage
        UserDefaults.standard.set(toggle, forKey: "mySwitch")
        
        // ✅ Apply custom navigation bar appearance here
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear // or your AppColors.lightBlue if you want a solid color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white // back button color
        navigationController?.navigationBar.isTranslucent = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
                   .addObserver(self,
                    selector: #selector(statusManager),
                    name: .flagsChanged,
                    object: nil)
        addBackgroundImage()
        addSubviews()
        setupConstraints()
        updateUserInterface()
        
        setupStackView()
        returnButton()
        oneWayButton()
        makeOneAdult()
    }
    
    
    
    func addSubviews() {
        [mainLabel, contentView].forEach(view.addSubview)
    }

    private func makeOneAdult() {
        let staticAdult =  Passenger(name: nil, surname: nil, sex: nil, birthday: nil, type: .adult)
        if(self.passengers.count == 0) {
            self.passengers.insert(staticAdult, at: 0)
        }
        if(self.searchFlightModel.passengers == nil) {
            self.searchFlightModel.passengers = [staticAdult]
        }
    }
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let top =  stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        let leading = stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20)
        let height = stackView.heightAnchor.constraint(equalToConstant: 40)

        NSLayoutConstraint.activate([top,leading,height])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.layer.cornerRadius = 6
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = AppColors.lightGray.cgColor

    }
    
    private func returnButton() {
        stackView.addArrangedSubview(returnButtonOutlet)
        returnButtonOutlet.setTitle("Return", for: .normal)
        returnButtonOutlet.backgroundColor = AppColors.lightBlue
        returnButtonOutlet.setTitleColor(.white, for: .normal)
        returnButtonOutlet.layer.cornerRadius = 4
        returnButtonOutlet.addTarget(self, action: #selector(returnButtonLogic), for: .touchUpInside)
        returnButtonOutlet.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func oneWayButton() {
        stackView.addArrangedSubview(oneWayButtonOutlet)
        oneWayButtonOutlet.setTitle("One way", for: .normal)
        oneWayButtonOutlet.backgroundColor = AppColors.almostWhite
        oneWayButtonOutlet.setTitleColor(.black, for: .normal)
        oneWayButtonOutlet.layer.cornerRadius = 4
        oneWayButtonOutlet.addTarget(self, action: #selector(oneWayLogic), for: .touchUpInside)
        oneWayButtonOutlet.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc private func returnButtonLogic() {
            toggle = false
        searchFlightModel.hasReturnFlight = true
            contentView.inputViews[.return]?.isUserInteractionEnabled = true
            contentView.inputViews[.return]?.value = "dd/mm/yyyy"
            returnButtonOutlet.backgroundColor = AppColors.lightBlue
            returnButtonOutlet.setTitleColor(.white, for: .normal)
            oneWayButtonOutlet.setTitleColor(.black, for: .normal)
            oneWayButtonOutlet.backgroundColor = .white
        UserDefaults.standard.set(toggle, forKey: "mySwitch")
        
    }
    @objc private func oneWayLogic() {
        toggle = true
        searchFlightModel.dateOfArrival = nil
        searchFlightModel.hasReturnFlight = false
        contentView.inputViews[.return]?.isUserInteractionEnabled = false
        contentView.inputViews[.return]?.value = "One way"
        oneWayButtonOutlet.backgroundColor = AppColors.lightBlue
        returnButtonOutlet.setTitleColor(.black, for: .normal)
        oneWayButtonOutlet.setTitleColor(.white, for: .normal)
        returnButtonOutlet.backgroundColor = .white
        UserDefaults.standard.set(toggle, forKey: "mySwitch")
    }
    
    func setupConstraints() {
        mainLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 10)
        mainLabel.autoPinEdge(toSuperviewMargin: .leading)
        
        contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20), excludingEdge: .top)
    }

}

extension SearchFlightsViewController: SearchFlightsInputViewDelegate {
    func didTapOnInputView(_ inputView: HomeFormEntryView, type: SearchFlightsDataEntry) {
        switch type {
        case .from:
            let selectAirportViewModel = SelectAirportViewModel(inputView: inputView, searchFlightModel: searchFlightModel)
            let selectAirportVC = SelectAirportViewController(viewModel: selectAirportViewModel)
            selectAirportVC.modalPresentationStyle = .fullScreen
            contentView.inputViews[.to]?.value = "Choose"
            present(selectAirportVC, animated: true, completion: nil)
        case .to:
            let selectAirportViewModel = SelectAirportViewModel(inputView: inputView, searchFlightModel: searchFlightModel)
            let selectAirportVC = SelectAirportViewController(viewModel: selectAirportViewModel)
            selectAirportVC.modalPresentationStyle = .fullScreen
            present(selectAirportVC, animated: true, completion: nil)
        case .departure:
            if let _ = searchFlightModel.arrivalAirportId,
               let _ = searchFlightModel.departureAirportId {
                let dateSelectionViewModel = DateSelectionViewModel(inputView: inputView, searchFlightModel: searchFlightModel)
                let selectDateVC = DateSelectionViewController(viewModel: dateSelectionViewModel)
                selectDateVC.delegate = self
                selectDateVC.oneWayTrue = toggle
                selectDateVC.modalPresentationStyle = .fullScreen
                present(selectDateVC, animated: true, completion: nil)
            }
        case .return:
            showOnlyReturnDateFlight = true
            if let _ = searchFlightModel.arrivalAirportId,
               let _ = searchFlightModel.departureAirportId {
                let dateSelectionViewModel = DateSelectionViewModel(inputView: inputView, searchFlightModel: searchFlightModel)
                let selectDateVC = DateSelectionViewController(viewModel: dateSelectionViewModel)
                selectDateVC.delegate = self
//                selectDateVC.oneWayTrue = toggle
                selectDateVC.getIfJustReturnDateFlight = showOnlyReturnDateFlight
                selectDateVC.modalPresentationStyle = .fullScreen
                present(selectDateVC, animated: true, completion: nil)
            }
            
        case .passengers:
            if let _ = searchFlightModel.arrivalAirportId,
               let _ = searchFlightModel.departureAirportId,
               let _ = searchFlightModel.dateOfDeparture {
                let passengersSelectionViewModel = SelectPassengersViewModel(model: searchFlightModel, inputView: inputView)
                let selectPassengersVC = SelectPassengersViewController(viewModel: passengersSelectionViewModel)
                selectPassengersVC.delegate = self
                selectPassengersVC.modalPresentationStyle = .fullScreen
                present(selectPassengersVC, animated: true, completion: nil)
            }
        }
    }
    
    func didTapSwitchDirections(_ searchView: SearchFlightsInputView) {
//        contentView.inputViews[.passengers]?.value = "Choose"
        contentView.inputViews[.departure]?.value = "dd/mm/yyyy"
        contentView.inputViews[.return]?.value = "dd/mm/yyyy"
        searchFlightModel.switchDirections()
    }
    
    func didTapSearch(_ searchView: SearchFlightsInputView) {
        if let _ = searchFlightModel.arrivalAirportId,
           let _ = searchFlightModel.departureAirportId,
           let _ = searchFlightModel.dateOfDeparture,
           let _ = searchFlightModel.passengers {
            let searchDepartureViewModel = SelectDepartureViewModel(
                                                searchFlightModel: searchFlightModel,
                                                selectedDepartureFlight: nil, passengerCount: searchFlightModel.passengers!)
            let selectDepartureFlightVC = SelectDepartureFlightViewController(viewModel: searchDepartureViewModel)
            navigationController?.pushViewController(selectDepartureFlightVC, animated: true)
        } else {
            self.view.makeToast("You need to fill all data", duration: 3.0, position: .bottom)
        }
    }
    
    func didTapNewSearch(_ searchView: SearchFlightsInputView) {
        toggle = false
        contentView.inputViews[.return]?.isUserInteractionEnabled = true
        returnButtonOutlet.backgroundColor = AppColors.lightBlue
        returnButtonOutlet.setTitleColor(.white, for: .normal)
        oneWayButtonOutlet.setTitleColor(.black, for: .normal)
        oneWayButtonOutlet.backgroundColor = .white
        searchFlightModel = SearchFlightModel()
    }
}

extension SearchFlightsViewController: DateSelectionViewControllerDelegate {
    func didSetDepartureDate(date: String) {
        searchFlightModel.dateOfDeparture = date
        contentView.inputViews[.departure]?.value = date
    }
    
    func didSetArrivalDate(date: String) {
        searchFlightModel.dateOfArrival = date
        contentView.inputViews[.return]?.value = date
    }
    
}

extension SearchFlightsViewController: SelectPassengersViewControllerDelegate {
    func didSelectPassengers() {
        print("hello")
        if let passengers = searchFlightModel.passengers {
            var adultCount = 0
            var babyCount = 0
            var childCount = 0
            for passenger in passengers {
                switch passenger.type {
                case .adult:
                    adultCount += 1
                case .inf:
                    babyCount += 1
                case .child:
                    childCount += 1
                }
            }
            var title = ""
            if adultCount == 1 {
                title.append("\(adultCount) Adult")
            }
            if adultCount > 1 {
                title.append("\(adultCount) Adults")
            }

            if childCount == 1  {
                title.append(", \(childCount) Child")
            }
            if childCount > 1 {
                title.append(", \(childCount) Children")
            }
            if babyCount > 0 {
                title.append(", \(babyCount) Infant")
            }
            contentView.inputViews[.passengers]?.value = title
        }
    }
}
