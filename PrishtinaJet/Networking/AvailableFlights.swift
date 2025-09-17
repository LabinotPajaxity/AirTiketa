//
//  AvailableFlights.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 2.7.21.
//

import Alamofire

private struct AvailableFlightsParameters: Encodable {
    let departureAirportId: String
    let arrivalAirportId: String
}

class AvailableFlights: BaseRequest {
    override var path: String {
        return "/flights/available"
    }
    
    init(departureAirportId: String?, arrivalAirportId: String?) {
        super.init()
        if let departureAirportId = departureAirportId,
           let arrivalAirportId = arrivalAirportId {
            let param = AvailableFlightsParameters(departureAirportId: departureAirportId,
                                                   arrivalAirportId: arrivalAirportId)
            queryParams = param.queryParams
        }
    }
    
    func perform(completion: @escaping (Result<AvailableFlightsResponse, Error>) -> Void) {
        AF.request(self).validate().responseDecodable(of: AvailableFlightsResponse.self) { response in
            switch response.result {
            case .success(let dates):
                completion(.success(dates))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct AvailableFlightsResponse: Decodable {
    let availableDates: [String]?
}
