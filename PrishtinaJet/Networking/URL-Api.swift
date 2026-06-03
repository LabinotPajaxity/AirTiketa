//
//  URL-Api.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 12.8.21..
//

import Foundation

// MARK: - API Environment
enum APIEnvironment {
    case dev
    case live
}

// Current environment
let currentEnvironment: APIEnvironment = .live

// MARK: - Base URL
var BASE_URL: String {
	switch currentEnvironment {
	case .dev:
		return "https://api.dev.bemyticket.com"
	case .live:
		return "https://web-api.airtiketa.eu"
	}
}

// MARK: - API Endpoints
var URL_REGISTER: String { return "\(BASE_URL)/api/v1/account" }
var URL_CHANGE_PASSWORD: String { return "\(BASE_URL)/api/v1/account/password" }
var URL_DETAIL_RESERVATION: String { return "\(BASE_URL)/api/v1/reservations/" }
var URL_TOTAL_PRICE: String { return "\(BASE_URL)/api/v1/reservations/previewPrice" }
var URL_FIND_MY_BOOKING: String { return "\(BASE_URL)/api/v1/reservations/search" }

// MARK: - User Defaults Keys
let KEY_IS_LOGGED_IN   = "KEY_IS_LOGGED_IN"
let KEY_CURRENT_USER   = "KEY_CURRENT_USER"
let KEY_PHONE_NUMBER   = "KEY_PHONE_NUMBER"
let KEY_TOKEN          = "KEY_CURRENT_USER_TOKEN"
let KEY_FULLNAME       = "KEY_FULLNAME"
let USER_JTI           = "USER_JTI"

// MARK: - Other Constants
var genderData = [" ", "Male", "Female"]
let NOTIF_USER_DATA_CHANGED = NSNotification.Name("NOTIF_USER_DATA_CHANGED")
