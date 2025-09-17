//
//  SelectDepartureFligtViewModel.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 6.5.21.
//

import UIKit

protocol SelectDepartureViewModelDelegate: AnyObject {
    func didGetFlight(departure: String, arrival: String)
    func didFailToGetFlights(with errorMessage: String)
}

class SelectDepartureViewModel {
    private var flights = [Flight]()
    var departure: Airport? 
    var arrival: Airport?
    var selectedDepartureFlight: Flight?
    var passangerCount: [Passenger] = []
    
    var flightsCount: Int {
        return flights.count
    }
    
    let searchFlightModel: SearchFlightModel
    
    init(searchFlightModel: SearchFlightModel, selectedDepartureFlight: Flight?, passengerCount: [Passenger]) {
        self.searchFlightModel = searchFlightModel
        self.selectedDepartureFlight = selectedDepartureFlight
        self.passangerCount = passengerCount
    }
    
    weak var delegate: SelectDepartureViewModelDelegate?
    
    func getFlights(type: GetFlightsType = .current) {
        GetFlights(model: searchFlightModel, type: type)
            .perform { [weak self] result in
            switch result {
            case .success(let response):
                self?.flights = response.flights.map { flight in
                    var updatedFlight = flight
//                    if updatedFlight.numberOfAvailableSeats == nil {
                        // Inject static seat number
                        updatedFlight = Flight(
                            id: flight.id,
                            flightDuration: flight.flightDuration,
                            timeOfDeparture: flight.timeOfDeparture,
                            timeOfArrival: flight.timeOfArrival,
                            numberOfAvailableSeats: updatedFlight.numberOfAvailableSeats, // static number
                            lowestPriceWithTax: flight.lowestPriceWithTax,
                            flightNumber: flight.flightNumber
                        )
//                    }
                    return updatedFlight
                }
                self?.departure = response.departureAirport
                self?.arrival = response.arrivalAirport
                self?.searchFlightModel.dateOfDeparture = response.dateOfDeparture
                self?.delegate?.didGetFlight(departure: response.departureAirport.name,
                                             arrival: response.arrivalAirport.name)

            case .failure(let error):
                self?.delegate?.didFailToGetFlights(with: error.localizedDescription)
            }
        }
    }
    
    func flight(at indexPath: IndexPath) -> Flight {
        return flights[indexPath.row]
    }
}

