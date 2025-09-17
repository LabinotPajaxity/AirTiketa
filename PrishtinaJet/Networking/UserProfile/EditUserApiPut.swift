//
//  EditUser.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 16.8.21..
//

import Foundation
import Alamofire

struct EditUserParamaters: Encodable {
    let fullName: String
    let email: String
    let phoneNumber: String
    let address: String
    let city: String
    let zipCode: String
    let country: String
    let gender: String
    let dateOfBirth: String
}


class EditUserApiPut {
//    override var path: String {
//        return "/account"
//    }
//
//    override var method: HTTPMethod {
//        return .put
//    }
    
     var headers: HTTPHeaders? {
        guard let accessToken = KeychainManager.shared.accessToken else {
            return []
        }
        return ["Authorization" : "Bearer " + accessToken]
    }
    static let instance = EditUserApiPut()
    
    func editProfile(fullName:String, email:String, phoneNumber:String,address:String ,city:String, zipCode:String,country: String, gender:String,dateOfBirth: String, completionHandler: @escaping(Bool, ADJUser) -> Void) {
        
        let params:[String:Any] = [
            "fullName":fullName,
            "email":email,
            "phoneNumber":phoneNumber,
            "address": address,
            "city":city,
            "zipCode":zipCode,
            "country":country,
            "gender":gender,
            "dateOfBirth": dateOfBirth
        ]
        
        let user = ADJUser()
        AF.request(URL_REGISTER, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            print(response.description)
            switch response.result {
            case .success(_):
//                guard let data = response.value as? [String:Any] else { return }
//
//                user = Mapper<ADJUser>().map(JSONObject: data, toObject: user)
                print(response)
                completionHandler(true, user)

            case let .failure(error):
                print(error)
                completionHandler(false, user)

            }
        }
        }
    }














































