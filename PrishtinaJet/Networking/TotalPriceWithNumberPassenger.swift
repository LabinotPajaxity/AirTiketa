//
//  TotalPriceWithNumberPassenger.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 29.9.21..
//

import Foundation
import Alamofire


class TotalPriceWithNumberPassenger {

    static let instance = TotalPriceWithNumberPassenger()

    func getTotalPriceWithNumberPassenger(
            numberOfAdults: Int,
            numberOfChildren: Int,
            numberOfInfants: Int,
            departureFlightId: String,
            returnFlightId: String?,
            completion:  @escaping (Result<TotalPriceModel, Error>) -> Void) {
                
        
            var params:[String:Any] = [
                "numberOfAdults":numberOfAdults,
                "numberOfChildren":numberOfChildren,
                "numberOfInfants":numberOfInfants,
                "departureFlightId": departureFlightId
            ]
                
            if returnFlightId != nil {
                params["returnFlightId"] = returnFlightId
            }
        
        AF.request(URL_TOTAL_PRICE , method: .get,  parameters: params).validate().responseDecodable(of: TotalPriceModel.self) { response in
            switch response.result {
            case  .success(let total):
                completion(.success(total))
            case let .failure(error):
                print(error)
                completion(.failure(error))
            }
    }
    }
}
