//
//  SelectedFlightsViewController.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 26.5.21.
//

import UIKit

class SelectedFlightsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellClass: SelectedFlightsCell.self)
        tableView.register(cellClass: EmptyReturnFlightCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = AppColors.almostWhite
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var bottomView: ModalBottomView = {
        let view = ModalBottomView.newAutoLayout()
        view.delegate = self
        view.chooseButton.setTitle("Continue", for: .normal)
        return view
    }()
    
    var selectedFlight: SelectedFlightModel
    var totalModel = [TotalPriceModel]()
    var sumPrice: String = " "
    
    init(model: SelectedFlightModel, isReturn: Bool) {
        self.selectedFlight = model
    
        super.init(nibName: nil, bundle: nil)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getTotatPrice()
        let oneWay : Bool = UserDefaults.standard.bool(forKey: "mySwitch")
        if selectedFlight.returnFlight?.id == nil {
            if oneWay == true {
                bottomView.chooseButton.isEnabled = true
            } else {
                bottomView.chooseButton.isEnabled = false
            }
        } else {
            bottomView.chooseButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
                   .addObserver(self,
                    selector: #selector(statusManager),
                    name: .flagsChanged,
                    object: nil)
        updateUserInterface()
        title = "Selected Flights"
        view.backgroundColor = .white
    }
        
    private func addSubviews() {
        [tableView, bottomView].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        tableView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
        bottomView.autoPinBelow(view: tableView)
        bottomView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                     attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    func makeTitleView(with title: String, isDeparture: Bool) -> UIView {
        let label = UILabel.newAutoLayout()
        label.textColor = AppColors.almostBlack
        let normalString = isDeparture ? "Departure: " : "Return: "
        label.attributedText = attributedText(withString: normalString + title, boldString: title, font: label.font)
        
        let headerView = UIView()
        headerView.addSubview(label)
        label.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
        return headerView
    }
    
    func getTotatPrice() {
        let adults = selectedFlight.passengers.filter { $0.type == PassengerSelectionType.adult }
        let children = selectedFlight.passengers.filter { $0.type == PassengerSelectionType.child }
        let babies = selectedFlight.passengers.filter { $0.type == PassengerSelectionType.inf }
        
        TotalPriceWithNumberPassenger.instance.getTotalPriceWithNumberPassenger(
            numberOfAdults: adults.count,
            numberOfChildren: children.count,
            numberOfInfants: babies.count,
            departureFlightId: selectedFlight.departureFlight.id,
            returnFlightId: selectedFlight.returnFlight?.id ?? nil) { result in
                
                switch result {
                case .success(let response):
                    self.bottomView.statusLabel.text = "Grand total:  " + String(response.reservationTotalPrice) + " " + response.currencyResponse.symbol
                    self.sumPrice = self.bottomView.statusLabel.text!
                    self.totalModel = [response]
                case .failure(let error):
                    print(error)
                }
            }
    }
}
extension SelectedFlightsViewController: ModalBottomViewDelegate {
    func didtapOnChooseButton() {
        let viewModel = PassengersViewModel(model: selectedFlight)
        
        let passengersVC = PassengersViewController(viewModel: viewModel, selectedFlight: selectedFlight)
        passengersVC.totalPriceDelegate = sumPrice
        navigationController?.pushViewController(passengersVC, animated: true)
    }
}



extension SelectedFlightsViewController: EmptyReturnFlightCellDelegate {
    func didTapOnReturnButton() {
        let searchFlightModel = SearchFlightModel()
        searchFlightModel.departureAirportId = selectedFlight.arrivalAirport.id
        searchFlightModel.arrivalAirportId = selectedFlight.departureAirport.id
        searchFlightModel.dateOfDeparture = selectedFlight.dateOfArrival
        searchFlightModel.dateOfArrival = selectedFlight.dateOfDeparture
        searchFlightModel.passengers = selectedFlight.passengers
        searchFlightModel.departureAirportName = selectedFlight.arrivalAirport.name
        searchFlightModel.arrivalAirportName = selectedFlight.departureAirport.name
        let viewModel = SelectDepartureViewModel(
                            searchFlightModel: searchFlightModel,
                            selectedDepartureFlight: selectedFlight.departureFlight, passengerCount: selectedFlight.passengers
)
        let selectArrivalVC = SelectDepartureFlightViewController(viewModel: viewModel, isArrival: true)
        navigationController?.pushViewController(selectArrivalVC, animated: true)
    }
}
