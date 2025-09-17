//
//  SignUpViewModel.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 19.5.21.
//

import UIKit

class SignUpViewModel {
    private var fullName: String?
    private var phoneNumber: String?
    private var email: String?
    private var password: String?
    private var confirmPass: String?
    private var country: String?

    private var address: String?
    private var city: String?
    private var zipCode: String?
    private var gender: String?
    private var dateOfBirth: String?
    
    
   
    
    private func isDataValid() -> Bool {
        var isValid = false
        [fullName, phoneNumber, email, password, confirmPass, phoneNumber].forEach { text in
            if let text = text {
                isValid = !text.isEmpty && text.count > 0
            }
        }
        return isValid
    }
    
    func signUp() {
        if isDataValid() {
            let model = SignUpModel(fullName: fullName, email: email, phoneNumber: phoneNumber, password: password, address: address, city: city, zipCode: zipCode, country: country, gender: gender, dateOfBirth: dateOfBirth)
            SignUp(model: model).perform { result in
                switch result {
                case .success():
                    // navigate somewhere
                    print("SUCCESS")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct SignUpModel {
    let fullName: String?
    let email: String?
    let phoneNumber: String?
    let password: String?
    let address: String?
    let city: String?
    let zipCode: String?
    let country: String?
    let gender: String?
    let dateOfBirth: String?
}
