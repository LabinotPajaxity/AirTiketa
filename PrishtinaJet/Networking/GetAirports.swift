//
//  GetAirports.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/12/21.
//

import Foundation
import Alamofire

private struct GetAirportsParameters: Encodable {
    let departureAirportId: String
}

class GetAirports: BaseRequest {
    override var path: String {
        return "/countries/airports"
    }
    
    init(departureAirportId: String? = nil) {
        super.init()
        if let departureAirportId = departureAirportId {
            let params = GetAirportsParameters(departureAirportId: departureAirportId)
            queryParams = params.queryParams
        }
    }
    
    func perform(completion: @escaping (Result<[Country], Error>) -> Void) {
        AF.request(self).validate().responseDecodable(of: [Country].self) { response in
            switch response.result {
            case .success(let countries):
                completion(.success(countries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
