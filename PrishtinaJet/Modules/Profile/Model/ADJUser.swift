//
//  ADJUser.swift
//  Gastrolieferung
//
//  Created by MacBook on 02/10/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

 import ObjectMapper

let kFullName          = "fullName"
let kUserEmail         = "email"
let kPhoneNumber       = "phoneNumber"
let kUserAddress       = "address"
let kUserCity          = "city"
let kUserZipCode       = "zipCode"

let kUserCountry       = "country"
let kUserGender        = "gender"
let kUserDateOfBirth   = "dateOfBirth"




class ADJUser: NSObject, Mappable {
    var userfirstName:       String?
    var useremail:           String?
    var userPhone:           String?
    var userAddress:         String?
    var userCity:            String?
    var userZipCode:         String?
    
    var userCountry:         String?
    var userGender:          String?
    var userDateOfBirth:     String?
    
    override init() {
        super.init()
    }
    
 required init?(map: Map) {
        
    }
    
  func mapping(map: Map){
    userfirstName         <- map[kFullName]
    useremail             <- map[kUserEmail]
    userPhone             <- map[kPhoneNumber]
    userAddress           <- map[kUserAddress]
    userCity              <- map[kUserCity]
    userZipCode           <- map[kUserZipCode]
    
    userCountry           <- map[kUserCountry]
    userGender            <- map[kUserGender]
    userDateOfBirth       <- map[kUserDateOfBirth]
    }
}



