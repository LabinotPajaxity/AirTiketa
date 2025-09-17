//
//  SelectedFlightsCell.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 26.5.21.
//

import UIKit

class SelectedFlightsCell: UITableViewCell {
    private let topView: SelectDepartureTopView = {
        let view = SelectDepartureTopView.newAutoLayout()
        view.autoSetDimension(.height, toSize: 100)
        view.layer.cornerRadius = 7
        return view
    }()
    
    private let flightInfoView: FlightInfoView = {
        return FlightInfoView.newAutoLayout()
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = AppColors.almostWhite
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [topView, flightInfoView].forEach(contentView.addSubview)
    }
    
    private func setupConstraints() {
        topView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), excludingEdge: .bottom)
        flightInfoView.autoPinBelow(view: topView)
        flightInfoView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func configure(with flightInfo: FlightInfo) {
        topView.arrival = flightInfo.arrivalAirport.code
        topView.departure = flightInfo.departureAirport.code
        flightInfoView.departurePlaceLabel.text = flightInfo.departureAirport.code
        flightInfoView.arrivalPlaceLabel.text = flightInfo.arrivalAirport.code
        flightInfoView.departureTimeLabel.text = String(flightInfo.flight.timeOfDeparture.prefix(5))
        flightInfoView.arrivalTimeLabel.text = String(flightInfo.flight.timeOfArrival.prefix(5))
        flightInfoView.priceLabel.text = "from \(flightInfo.flight.lowestPriceWithTax)"
        flightInfoView.flightDurationLabel.text = flightInfo.flight.flightDuration
        
        flightInfoView.directFlightLabel.text = "Direct Flight"
        flightInfoView.flightNumberLabel.text = "Flight number: \(flightInfo.flight.flightNumber)"
        flightInfoView.baggageInfoLabel.text = "20kg Check-in Baggage"
        
    }
    
    func configureForReturnFlight(with flightInfo: FlightInfo) {
        topView.arrival = flightInfo.departureAirport.code
        topView.departure = flightInfo.arrivalAirport.code
        flightInfoView.departurePlaceLabel.text = flightInfo.arrivalAirport.code
        flightInfoView.arrivalPlaceLabel.text = flightInfo.departureAirport.code
        flightInfoView.departureTimeLabel.text = String(flightInfo.flight.timeOfDeparture.prefix(5))
        flightInfoView.arrivalTimeLabel.text = String(flightInfo.flight.timeOfArrival.prefix(5))
        flightInfoView.priceLabel.text = "from \(flightInfo.flight.lowestPriceWithTax)"
        flightInfoView.flightDurationLabel.text = flightInfo.flight.flightDuration
        
        flightInfoView.directFlightLabel.text = "Direct Flight"
        flightInfoView.flightNumberLabel.text = "Flight number: \(flightInfo.flight.flightNumber)"
        flightInfoView.baggageInfoLabel.text = "20kg Check-in Baggage"
    }
}
