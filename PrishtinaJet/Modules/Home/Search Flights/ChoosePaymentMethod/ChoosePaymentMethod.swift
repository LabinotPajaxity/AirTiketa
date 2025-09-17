//
//  ChoosePaymentMethod.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 12.6.22..
//

import Foundation
import UIKit

class ChoosePaymentMethod: UIViewController {
    
    private let containerViewForStripe: ShadowView = {
        let view = ShadowView.newAutoLayout()
        view.backgroundColor = .white
        view.addShadowBorder(radius: 7)
        view.autoSetDimension(.height, toSize: 80)
        return view
    }()
    
    private var stripeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "stripe"), for: .normal)
        button.addTarget(self, action: #selector(stripeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = AppColors.almostBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let viewModel: PassengersViewModel
    var responsePath = [PaymentResponse]()
    var totalModel = [TotalPriceModel]()
    var selectedFlight: SelectedFlightModel
    
    init(viewModel: PassengersViewModel, selectedFlight: SelectedFlightModel) {
        self.viewModel = viewModel
        self.selectedFlight = selectedFlight
        super.init(nibName: nil, bundle: nil)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTotalPrice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.almostWhite
    }
    
    private func addSubviews() {
        [containerViewForStripe, stripeButton, priceLabel].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        containerViewForStripe.translatesAutoresizingMaskIntoConstraints = false
        stripeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerViewForStripe.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            containerViewForStripe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerViewForStripe.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            containerViewForStripe.heightAnchor.constraint(equalToConstant: 80),
            
            stripeButton.topAnchor.constraint(equalTo: containerViewForStripe.topAnchor, constant: 20),
            stripeButton.leadingAnchor.constraint(equalTo: containerViewForStripe.leadingAnchor, constant: 10),
            stripeButton.heightAnchor.constraint(equalToConstant: 40),
            stripeButton.widthAnchor.constraint(equalToConstant: 120),
            
            priceLabel.centerYAnchor.constraint(equalTo: stripeButton.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: containerViewForStripe.trailingAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func getTotalPrice() {
        let adults = selectedFlight.passengers.filter { $0.type == .adult }
        let children = selectedFlight.passengers.filter { $0.type == .child }
        let babies = selectedFlight.passengers.filter { $0.type == .inf }
        
        TotalPriceWithNumberPassenger.instance.getTotalPriceWithNumberPassenger(
            numberOfAdults: adults.count,
            numberOfChildren: children.count,
            numberOfInfants: babies.count,
            departureFlightId: selectedFlight.departureFlight.id,
            returnFlightId: selectedFlight.returnFlight?.id
        ) { result in
            switch result {
            case .success(let response):
                self.priceLabel.text = "\(response.reservationTotalPrice) \(response.currencyResponse.symbol)"
                self.totalModel = [response]
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func stripeTapped() {
        print("Stripe selected")
        UserDefaults.standard.setPaymentType(value: "STRIPE")
        makePaymentFinished()
    }
    
    private func makePaymentFinished() {
        Payment(viewModel: viewModel).perform { result in
            switch result {
            case .success(let path):
                self.responsePath = [path]
                // hap WebView me stripe checkout URL
                let vc = PaymentInWebView()
                vc.responseUrl = [path]
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .failure(let error):
                print(error)
                self.showErrorAlert(message: "\(error.localizedDescription)")
            }
        }
    }
}
