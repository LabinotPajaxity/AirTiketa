//
//  GetCountries.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 27.5.21.
//

import Foundation
import Alamofire

class GetCountries: BaseRequest {
    override var path: String {
        return "/countries"
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
