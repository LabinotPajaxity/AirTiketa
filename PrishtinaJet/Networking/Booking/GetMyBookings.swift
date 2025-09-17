//
//  GetMyBookings.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 19.8.21..
//

import Foundation
import UIKit
import Alamofire

class GetMyBookings: BaseRequest {
    override var path: String {
        return "/reservations"
    }
    let viewModelToken = RefreshTokenViewModel()
    
    override var headers: HTTPHeaders? {
        guard let accessToken = KeychainManager.shared.accessToken else {
            return []
        }
        return ["Authorization" : "Bearer " + accessToken]
    }
    
    func perform(completion: @escaping (Result<[Bookings], Error>) -> Void) {
        AF.request(self).validate().responseDecodable(of: [Bookings].self) { response in
            
        if response.response?.statusCode == 401 {
            self.viewModelToken.refreshToken(grant_type: "refresh_token", refresh_token: KeychainManager.shared.accessRefreshToken!) { response in
                
                switch response {
                case .success(let token):
                    AF.request(self).validate().responseDecodable(of: [Bookings].self) { response in
                        switch response.result {
                        case .success(let booking):
                            completion(.success(booking))
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
            case .success(let booking):
                completion(.success(booking))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
