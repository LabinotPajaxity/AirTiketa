//
//  SearchFlightCell.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 13.4.21.
//

import UIKit

final class SearchFlightCell: UITableViewCell {
    
    // MARK: - UI
    private let flightInfoView: FlightInfoView = {
        let view = FlightInfoView.newAutoLayout()
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        // add spacing between cells
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    // MARK: - Configure
    // MARK: - Configure
    func configure(with flight: Flight, departureCode: String?, arrivalCode: String?) {
        let availableSeats = flight.flightDuration
        configureFlightDetails(flight, departureCode: departureCode, arrivalCode: arrivalCode, availableSeats: availableSeats)
    }

    // MARK: - Configure Flight Details
    private func configureFlightDetails(
        _ flight: Flight,
        departureCode: String?,
        arrivalCode: String?,
        availableSeats: String
    ) {
        flightInfoView.departurePlaceLabel.text = departureCode
        flightInfoView.arrivalPlaceLabel.text = arrivalCode
        flightInfoView.departureTimeLabel.text = String(flight.timeOfDeparture.prefix(5))
        flightInfoView.arrivalTimeLabel.text = String(flight.timeOfArrival.prefix(5))
        flightInfoView.seatsLabel.text = availableSeats
        flightInfoView.priceLabel.text = "from \(flight.lowestPriceWithTax)"
        
        flightInfoView.directFlightLabel.text = "Direct Flight"
        flightInfoView.flightNumberLabel.text = "Flight number: \(flight.flightNumber)"
        flightInfoView.baggageInfoLabel.text = "20kg Check-in Baggage"

        flightInfoView.flightDurationLabel.text = DateHelper.getDuration(
            departure: flight.timeOfDeparture,
            arrival: flight.timeOfArrival
        )
    }

    
    // MARK: - Selection Highlight
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        flightInfoView.containerView.layer.borderWidth = selected ? 1 : 0
        flightInfoView.containerView.layer.borderColor = selected
            ? AppColors.lightBlue.cgColor
            : UIColor.clear.cgColor
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.backgroundColor = AppColors.almostWhite
        contentView.addSubview(flightInfoView)
    }
    
    private func setupConstraints() {
        flightInfoView.autoPinEdgesToSuperviewEdges()
    }
}
