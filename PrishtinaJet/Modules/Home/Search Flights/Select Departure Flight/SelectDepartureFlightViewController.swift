//
//  SelectDepartureFlightViewController.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 9.4.21.
//

import UIKit

//protocol SelectArrivalFlightDelegate: AnyObject {
//    func didSelectArrivalFlight(_ flightInfo: FlightInfo)
//}

//protocol ChangeDateFlight {
//    func selectedDate(date: String)
//}

class SelectDepartureFlightViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppColors.almostWhite
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(cellClass: SearchFlightCell.self)
        return tableView
    }()
    
    lazy var continueButtonView: ContinueButtonView = {
        let continueView = ContinueButtonView.newAutoLayout()
        continueView.delegate = self
        return continueView
    }()
    
    private lazy var stackView: SelectDepartureTopView = {
        let view = SelectDepartureTopView.newAutoLayout()
        return view
    }()
    
    private lazy var dateView: SelectDepartureDateView = {
        let view = SelectDepartureDateView.newAutoLayout()
        view.delegate = self
        return view
    }()
    
    let viewModel: SelectDepartureViewModel
    var isArrival: Bool
    var selectedFlight: Flight?
    
//    weak var arrivalDelegate: SelectArrivalFlightDelegate?
//    var delegateDate: ChangeDateFlight?

    
    init(viewModel: SelectDepartureViewModel, isArrival: Bool = false) {
        self.isArrival = isArrival
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
                   .addObserver(self,
                    selector: #selector(statusManager),
                    name: .flagsChanged,
                    object: nil)
        updateUserInterface()
        addSubviews()
        setupViews()
        setupConstraints()
        viewModel.getFlights()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if !isArrival {
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                   for: UIBarMetrics.default)
        }
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.newRedColorForALL
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        navigationItem.title = isArrival ? "Select Arrival Flight" : "Select Departure Flight"
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationController?.navigationBar.tintColor = .white // back button + bar buttons
        navigationController?.navigationBar.isTranslucent = false
    }

    
    private func setupViews() {
        view.backgroundColor = .white
        
        stackView.departure = viewModel.searchFlightModel.departureAirportName
        stackView.arrival = viewModel.searchFlightModel.arrivalAirportName
        dateView.dateLabel.text = viewModel.searchFlightModel.dateOfDeparture
    }
    
    func addSubviews() {
        let header  = SelectDepartureHeaderView(width: tableView.frame.width)
        tableView.tableHeaderView = header
        
        [
            stackView,
            dateView,
            tableView,
            continueButtonView
        ]
        .forEach(view.addSubview)
    }
    
    func setupConstraints() {
        stackView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        dateView.autoPinBelow(view: stackView)
        tableView.autoPinBelow(view: dateView)
        tableView.autoPinEdge(.bottom, to: .top, of: continueButtonView)
//        continueButtonView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .top)
        // Move continueButtonView a bit up from bottom
        continueButtonView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0), excludingEdge: .top)

        
    }
}

extension SelectDepartureFlightViewController: SelectDepartureViewModelDelegate {
    func didGetFlight(departure: String, arrival: String) {
        dateView.dateLabel.text = viewModel.searchFlightModel.dateOfDeparture
        tableView.reloadData()
    }
    
    func didFailToGetFlights(with errorMessage: String) {
        print("error")
        tableView.reloadData()
    }
}

extension SelectDepartureFlightViewController: SelectDepartureDateViewDelegate {
    func didTapOnNext() {
        viewModel.getFlights(type: .next)
        continueButtonView.continueButton.isEnabled = false
    }
    
    func didTapOnPrevious() {
        viewModel.getFlights(type: .previous)
        continueButtonView.continueButton.isEnabled = false
    }
}

extension SelectDepartureFlightViewController: ContinueButtonDelegate {
    func didTapContinueButton() {
        if isArrival {
            
            
            if  let selectedFlight = selectedFlight,
                let departureAirport = viewModel.departure,
                let arrivalAirport = viewModel.arrival,
                let dateOfDeparture = viewModel.searchFlightModel.dateOfDeparture,
                let dateOfArrival = viewModel.searchFlightModel.dateOfArrival,
                let passengers = viewModel.searchFlightModel.passengers,
                let selectedDepartureFlight = viewModel.selectedDepartureFlight {
               
                let model = SelectedFlightModel(
                                dateOfDeparture: dateOfArrival,
                                dateOfArrival: dateOfDeparture,
                                departureAirport: arrivalAirport,
                                arrivalAirport: departureAirport,
                                departureFlight: selectedDepartureFlight,
                                returnFlight: selectedFlight,
                                returnDepartureAirport: arrivalAirport,
                                returnArrivalAirport: departureAirport,
                                passengers: passengers
                            )

                let selectedFlightsVC = SelectedFlightsViewController(model: model, isReturn: true)
                navigationController?.pushViewController(selectedFlightsVC, animated: true)
            }
        } else {
            if let selectedFlight = selectedFlight,
               let departureAirport = viewModel.departure,
               let arrivalAirport = viewModel.arrival,
               let dateOfDeparture = viewModel.searchFlightModel.dateOfDeparture,
               let passengers = viewModel.searchFlightModel.passengers {
                
                let model = SelectedFlightModel(
                                dateOfDeparture: dateOfDeparture,
                                dateOfArrival: viewModel.searchFlightModel.dateOfArrival,
                                departureAirport: departureAirport,
                                arrivalAirport: arrivalAirport,
                                departureFlight: selectedFlight,
                                returnFlight: nil,
                                passengers: passengers
                            )
                
                let selectedFlightsVC = SelectedFlightsViewController(model: model, isReturn: false)
                navigationController?.pushViewController(selectedFlightsVC, animated: true)
            }
        }
    }
}
