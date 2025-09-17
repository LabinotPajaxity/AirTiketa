//
//  GetUserInfo.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 15.8.21..
//

import Foundation
import Alamofire

class GetUserInfo: BaseRequest {
    override var path: String {
        return "/account"
    }
    let viewModelToken = RefreshTokenViewModel()

    
    override var headers: HTTPHeaders? {
        guard let accessToken = KeychainManager.shared.accessToken else {
            return []
        }
        return ["Authorization" : "Bearer " + accessToken]
    }
    
    func perform(completion: @escaping (Result<User, Error>) -> Void) {
        AF.request(self).validate().responseDecodable(of: User.self) { response in
            
            if response.response?.statusCode == 401 {
                self.viewModelToken.refreshToken(grant_type: "refresh_token", refresh_token: KeychainManager.shared.accessRefreshToken!) { response in
                    
                    switch response {
                    case .success(let token):
                        AF.request(self).validate().responseDecodable(of: User.self) { response in
                            switch response.result {
                            case .success(let countries):
                                print(countries)
                                completion(.success(countries))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                        print(token)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            switch response.result {
            case .success(let countries):
                print(countries)
                completion(.success(countries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
