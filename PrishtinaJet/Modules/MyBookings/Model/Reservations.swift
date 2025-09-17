//
//  Reservations.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 18.8.21..
//

import Foundation

final class Bookings: Codable {
    let year: Int
    var isOpened: Bool? = false
    var reservations: [Reservations]
    
    init(year: Int, isOpened: Bool?, reservations: [Reservations]) {
        self.year = year
        self.isOpened = isOpened
        self.reservations = reservations
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Bookings(year: year, isOpened: isOpened, reservations: reservations)
        return copy
    }
}

struct Reservations: Codable {
    let id : String
    let confirmationCode: Int
    let travelers: [Travelers]
}

struct Flights: Codable {
    let id: String?
    let dateOfDeparture: String?
    let timeOfDeparture: String?
    let timeOfArrival: String?
    let departureAirport : String?
    let arrivalAirport: String?
}

