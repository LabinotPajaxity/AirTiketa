//
//  KeychainManager.swift
//  Capital
//
//  Created by Blerd Foniqi on 7/2/21.
//

import Foundation
import KeychainAccess

class KeychainManager {
    enum Keys: String {
        case token, refreshToken, tokenType, email, username
    }

    private let keychain: Keychain

    static let shared = KeychainManager()
    
    var accessToken: String? {
        return keychain[Keys.token.rawValue]
    }
    
    var accessEmail: String? {
        return keychain[Keys.email.rawValue]
    }
    
    
    var accessUsername: String? {
        return keychain[Keys.username.rawValue]
    }
    
    var accessRefreshToken: String? {
        return keychain[Keys.refreshToken.rawValue]
    }
    
    var accessTokenType: String? {
        return keychain[Keys.tokenType.rawValue]
    }

    private init() {
        let seerviceName = Bundle.main.bundleIdentifier ?? "com.prishtinajett.ios"
        keychain = Keychain(service: seerviceName)
    }

    func store(token: String) {
        keychain[Keys.token.rawValue] = token
    }
    
    func store(email: String) {
        keychain[Keys.email.rawValue] = email
    }
    
    func store(username: String) {
        keychain[Keys.username.rawValue] = username
    }
    
    

    func store(refreshToken: String) {
        keychain[Keys.refreshToken.rawValue] = refreshToken
    }

    func store(tokenType: String) {
        keychain[Keys.tokenType.rawValue] = tokenType
    }

    func clearToken() {
        keychain[Keys.token.rawValue] = nil
    }
    
    func clearEmail() {
        keychain[Keys.token.rawValue] = nil
    }
    
    func clearUsername() {
        keychain[Keys.username.rawValue] = nil
    }
    

    func clearRefreshToken() {
        keychain[Keys.refreshToken.rawValue] = nil
    }

    func clearTokenType() {
        keychain[Keys.tokenType.rawValue] = nil
    }

    func isLoggedIn() -> Bool {
        guard keychain[Keys.token.rawValue] != nil,
              keychain[Keys.refreshToken.rawValue] != nil,
              keychain[Keys.username.rawValue] != nil,
              keychain[Keys.email.rawValue] != nil,
              keychain[Keys.tokenType.rawValue] != nil else {
            return false
        }
        return true
    }
    
    func clearAll() {
        do {
            try keychain.removeAll()
        } catch {
            print(error.localizedDescription)
        }
    }
}
