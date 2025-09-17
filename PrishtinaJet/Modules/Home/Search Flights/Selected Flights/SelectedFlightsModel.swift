//
//  SelectedFlightsModel.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 8.6.21.
//

import Foundation

struct SelectedFlightModel {
    let dateOfDeparture: String
    var dateOfArrival: String?
    let departureAirport: Airport
    let arrivalAirport: Airport
    let departureFlight: Flight
    var returnFlight: Flight?
    var returnDepartureAirport: Airport?
    var returnArrivalAirport: Airport?
    var passengers: [Passenger]
}

struct FlightInfo {
    let flight: Flight
    let departureAirport: Airport
    let arrivalAirport: Airport
}
