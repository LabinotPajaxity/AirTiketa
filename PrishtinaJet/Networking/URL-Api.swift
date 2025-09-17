//
//  URL-Api.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 12.8.21..
//

import Foundation



//MARK: - User Constants
let BASE_URL = "https://api.dev.bemyticket.com"

var genderData = [" ", "Male", "Female"]

let URL_REGISTER = "https://api.dev.bemyticket.com/api/v1/account"
let URL_CHANGE_PASSWORD = "https://api.dev.bemyticket.com/api/v1/account/password"

let KEY_IS_LOGGED_IN       = "KEY_IS_LOGGED_IN"
let KEY_CURRENT_USER       = "KEY_CURRENT_USER"
let KEY_PHONE_NUMBER       = "KEY_PHONE_NUMBER"

let KEY_TOKEN              = "KEY_CURRENT_USER_TOKEN"
let KEY_FULLNAME           = "KEY_FULLNAME"
let USER_JTI                = "USER_JTI"
let URL_DETAIL_RESERVATION = "https://api.dev.bemyticket.com/api/v1/reservations/"
let LOGIN_URL  = "https://api.prjet.linkplus-it.com/oauth/token"
let URL_TOTAL_PRICE = "https://api.dev.bemyticket.com/api/v1/reservations/previewPrice"
let URL_FIND_MY_BOOKING = "https://api.dev.bemyticket.com/api/v1/reservations/search"

let NOTIF_USER_DATA_CHANGED = NSNotification.Name("NOTIF_USER_DATA_CHANGED")
