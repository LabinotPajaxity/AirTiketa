//
//  SignUp.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 23.4.21.
//

import Foundation
import Alamofire

struct SignUpParameters: Encodable {
    let fullName: String
    let email: String
    let phoneNumber: String
    let password: String
    let address: String
    let city: String
    let zipCode: String
    let country: String
    let gender: String
    let dateOfbirth: String
}

class SignUp: BaseRequest {
    override var path: String {
        return "/customers"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var headers: HTTPHeaders? {
        return [
            HTTPHeader(name: "Content-Type", value: "application/json")]
    }
    
    init(model: SignUpModel) {
        super.init()
        if let fullName = model.fullName,
           let email = model.email,
           let phone = model.phoneNumber,
           let password = model.password,
           let address = model.address,
           let city = model.city,
           let zipCode = model.zipCode,
           let country = model.country,
           let dateOfBirth = model.dateOfBirth,
           let gender = model.gender {
            let params = SignUpParameters(fullName: fullName, email: email, phoneNumber: phone, password: password, address: address, city: city, zipCode: zipCode, country: country,gender: gender ,dateOfbirth: dateOfBirth)
            parameters = params
        }
    }
    
    func perform(completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request(self).validate().response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

