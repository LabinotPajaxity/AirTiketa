//
//  DateSelectionViewModel.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/23/21.
//

import Foundation

protocol DateSelectionViewModelDelegate: AnyObject {
    func didGetDates()
}

class DateSelectionViewModel {
    let inputView: HomeFormEntryView
    let searchFlightModel: SearchFlightModel
    
    var departureDates: [String] = []
    var arrivalDates: [String] = []
    weak var delegate: DateSelectionViewModelDelegate?
    
    init(inputView: HomeFormEntryView, searchFlightModel: SearchFlightModel) {
        self.inputView = inputView
        self.searchFlightModel = searchFlightModel
    }
    
    func getAvailableDepartureFlights() {
        AvailableFlights(departureAirportId: searchFlightModel.departureAirportId,
                         arrivalAirportId: searchFlightModel.arrivalAirportId)
            .perform { [weak self] result in
                switch result {
                case .success(let dates):
                    self?.departureDates = dates.availableDates ?? []
                    self?.delegate?.didGetDates()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getAvailableArrivalFlights() {
        AvailableFlights(departureAirportId: searchFlightModel.arrivalAirportId,
                         arrivalAirportId: searchFlightModel.departureAirportId)
            .perform { [weak self] result in
                switch result {
                case .success(let dates):
                    self?.arrivalDates = dates.availableDates ?? []
                    self?.delegate?.didGetDates()
                case .failure(let error):
                    print(error)
                }
            }
    }
}
