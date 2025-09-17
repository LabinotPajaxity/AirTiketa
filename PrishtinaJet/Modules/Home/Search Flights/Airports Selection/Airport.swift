//
//  Airport.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/2/21.
//

import Foundation

struct Country: Codable {
    let id: String
    let code: String
    let name: String
    let airports: [Airport]
}

struct Airport: Codable {
    let id: String
    let name: String
    let code: String?
    let location: String?
    let number: String?
    let countryName: String?
    let countryCode: String?
}
