//
//  TotalPriceWithNumberPassengerModel.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 29.9.21..
//

import Foundation

class TotalPriceModel: Codable {
    let numberOfAdults: Int
    let numberOfChildren: Int
    let numberOfInfants: Int
    let departureTotalPrice: Double
    let returnTotalPrice: Double?
    let totalTaxes: Double
    let reservationTotalPrice: Double
    let currencyResponse: CurrencyResponse
}

class CurrencyResponse: Codable {
    let id : String
    let name: String
    let isoCode: String
    let symbol: String
}
