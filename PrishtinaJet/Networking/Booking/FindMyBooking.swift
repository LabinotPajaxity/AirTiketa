//
//  FindMyBooking.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 12.10.21..
//

import Foundation
import Alamofire

class FindMyBooking {
    
    static let instance = FindMyBooking()
    
     var headers: HTTPHeaders? {
        guard let accessToken = KeychainManager.shared.accessToken else {
            return []
        }
        return ["Authorization" : "Bearer " + accessToken]
    }
    
    func findMyBooking(lastName: String,
                       confirmationCode: Int, completion:  @escaping (Result<ReservationDetail, Error>) -> Void) {
        
        let params:[String:Any] = [
            "lastName": lastName,
            "confirmationCode": confirmationCode
        ]
        
        AF.request(URL_FIND_MY_BOOKING, method: .get, parameters: params, headers: headers).validate().responseDecodable(of: ReservationDetail.self) { response in
            switch response.result {
            case .success(let FinderBooking):
                completion(.success(FinderBooking))
            case let .failure(error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
