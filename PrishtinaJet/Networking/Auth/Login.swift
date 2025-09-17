//
//  Login.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 20.4.21.
//

import Foundation
import Alamofire
import JWTDecode
import UIKit


private struct LoginParameters: Encodable {
    let username: String
    let password: String
    let grant_type: String
}

extension Notification.Name {
public static let myNotificationKey = Notification.Name(rawValue: "myNotificationKey")
}

class Login: BaseRequest {
    override var path: String {
        return "/oauth/token"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var headers: HTTPHeaders? {
        return [
            HTTPHeader(name: "Authorization", value: "Basic cHJqZXRfY2xpZW50X2lkOnByamV0X3NlY3JldA=="),
            HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded")
        ]
    }
    
    init(username: String, password: String) {
        super.init()
        usesCleanBaseUrl = true
        parameters = LoginParameters(username: username, password: password, grant_type: "password")
    }
    
    
    func perform(completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let encodedURLRequest = try? URLEncoding.default.encode(self, with: parameters?.dictionary) else {
            return
        }
        AF.request(encodedURLRequest).validate().responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
                case .success(let response):
                    do {
                        let roleAdmin = "ROLE_ADMIN"
                        let roleAgent = "ROLE_AGENT"
                        
                        let jwt = try JWTDecode.decode(jwt: response.accessToken)
                        let authorities = jwt.claim(name: "authorities")
                        
                        let isAdmin = authorities.array!.contains(roleAdmin)
                        let isAgent = authorities.array!.contains(roleAgent)
                        
                        if (isAdmin || isAgent) {
                            
                            let notAllowed = [ "message" : "Not Allowed! ⚠️" ]
                               NotificationCenter.default.post(name: .myNotificationKey, object: nil, userInfo: notAllowed)

                        } else {
                            KeychainManager.shared.store(token: response.accessToken)
                            KeychainManager.shared.store(refreshToken: response.refreshToken)
                            KeychainManager.shared.store(tokenType: response.tokenType)
                            KeychainManager.shared.store(username: response.fullName)
                            KeychainManager.shared.store(email: response.email)
                            print(response)
                            completion(.success(response))
                        }
                      
                    } catch let error as NSError {
                        print(error)
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
