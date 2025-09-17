//
//  RefreshTokenViewModel.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 9.9.21..
//

import UIKit

class RefreshTokenViewModel {
    
    private func isDataValid(for grant_type: String, _ refresh_token: String) -> Bool {
        var isValid = false
        [grant_type, refresh_token].forEach { text in
            isValid = !text.isEmpty && text.count > 0
        }
        return isValid
    }
    
    func refreshToken(grant_type: String,
                      refresh_token: String,
               completion: @escaping (Result<Void, Error>) -> Void) {
        if isDataValid(for: grant_type, refresh_token) {
            RefreshToken(grant_type: grant_type, refresh_token: refresh_token).perform { result in
                switch result {
                    case .success(_):
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }
}
