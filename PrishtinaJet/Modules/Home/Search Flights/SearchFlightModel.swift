//
//  SearchFlightModel.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 4/1/21.
//

import Foundation

class SearchFlightModel {
    var departureAirportName: String?
    var arrivalAirportName: String?
    var departureAirportId: String?
    var arrivalAirportId: String?
    var dateOfDeparture: String?
    var dateOfArrival: String?
    var hasReturnFlight = true
    var passengers: [Passenger]?
    
    func switchDirections() {
        let temp = departureAirportId
        departureAirportId = arrivalAirportId
        arrivalAirportId = temp
        
        let tempName = departureAirportName
        departureAirportName = arrivalAirportName
        arrivalAirportName = tempName
        
        dateOfDeparture = nil
        dateOfArrival = nil
        passengers = nil
    }
}

struct Passenger {
    var name: String?
    var surname: String?
    var sex: String?
    var birthday: String?
    let type: PassengerSelectionType
}
