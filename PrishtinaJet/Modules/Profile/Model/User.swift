//
//  UserModel.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 15.8.21..
//

import Foundation

struct User:Codable {
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
    let reservations: [Reservation]?
    
    
}


struct Reservation:Codable {
        let id : String?
        let confirmationCode: Int?
//        let createdDate: String?
//        let updatedDate: String?
        let travelers: [Travelers]
//        let flight: String?
//        let currency: Currency
}

struct Travelers:Codable {
    let id: String?
    let name: String?
    let surname: String?
    let number: Int?
    let ageCategory: String?
//    let gender: String?
//    let dateOfBirth: String?
//    let nationality: String?
//    let status: Bool?
//    let price: Price?
    let departureFlight: Flights?
    let returningFlight: Flights?
}

