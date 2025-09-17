//
//  LoginResponse.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 20.4.21.
//

import Foundation

struct LoginResponse: Decodable {
    let accessToken: String
    let tokenType: String
    let refreshToken: String
    let expiresIn: Int
    let scope: String
    let fullName: String
    let email: String
    let jti: String
    
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case scope
        case fullName
        case email
        case jti
    }
}
