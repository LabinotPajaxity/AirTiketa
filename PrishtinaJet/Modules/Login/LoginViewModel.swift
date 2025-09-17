//
//  LoginViewModel.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 21.5.21.
//

import UIKit

class LoginViewModel {
    
    private func isDataValid(for username: String, _ password: String) -> Bool {
        var isValid = false
        [username, password].forEach { text in
            isValid = !text.isEmpty && text.count > 0
        }
        return isValid
    }
    
    func login(username: String,
               password: String,
               completion: @escaping (Result<Void, Error>) -> Void) {
        if isDataValid(for: username, password) {
            Login(username: username, password: password).perform { result in
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
