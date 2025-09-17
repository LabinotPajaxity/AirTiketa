//
//  FindMyReservationModel.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 4.10.21..
//

import Foundation
class ReservationDetail: Codable {
    let id : String?
    let confirmationCode: Int?
    let travelers: [TravelersDetail]?
}

struct TravelersDetail:Codable {
    let id: String?
    let name: String?
    let surname: String?
    let ageCategory: String?
    let departureFlight: FlightDetails?
    let returningFlight: FlightDetails?
}

struct Customer: Codable {
    let id: String?
    let fullName: String?
    let email: String?
    let phoneNumber: String?
    let address: String?
    let city: String?
    let zipCode: String?
    let country: String?
    let gender: String?
    let dateOfBirth: String?
    let reservations: String?
}

struct FlightDetails: Codable {
    let id: String?
    let departureAirport: String?
    let departureAirportCode: String?
    let arrivalAirport: String?
    let arrivalAirportCode: String?
    let timeOfDeparture: String?
    let timeOfArrival: String?
    let dateOfDeparture: String?
    let dateOfArrival: String?
    let duration: String?
    let flightNumber:  String?
    let gate: String?
}
