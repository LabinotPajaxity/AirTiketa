////
////  ReservationDetails.swift
////  PrishtinaJet
////
////  Created by Pajaziti Labinot on 12.9.21..
////
//
//import Foundation
//

struct ResercationFinal: Codable {
    let reservationId: String
    let customerEmail: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case reservationId
        case customerEmail = "customer_email"
        case status
    }
}

class ReservationDetailModel: Codable {
    let id : String?
    let confirmationCode: Int?
    let departureFlight: String?
    let arrivalFlight: String?
    let departureReturnFlight: String?
    let arrivalReturnFlight: String?
    let timeOfDeparture: String?
    let timeOfArrival: String?
    let departureAirport: String?
    let arrivalAirport: String?
    let departureReturnAirport: String?
    let arrivalReturnAirport: String?
    let travelers: [TravelersDetailModel]
}
//
struct TravelersDetailModel:Codable {
    let id: String?
    let name: String?
    let surname: String?
    let ageCategory: String?
    let departureFlight: FlightDetailsModel?
    let returningFlight: FlightDetailsModel?
}

struct FlightDetailsModel: Codable {
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
    let flightNumber: String?
    let gate: String?
}
