//
//  GetFlights.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 6.5.21.
//

import Foundation
import Alamofire

private struct GetFlightsParameters: Encodable {
    let departureAirportId: String
    let arrivalAirportId: String
    let dateOfDeparture: String
    let hasReturnFlight: Bool
}

enum GetFlightsType {
    case current
    case next
    case previous
}

class GetFlights: BaseRequest {
    override var path: String {
        switch type {
        case .current:
            return "/flights"
        case .next:
            return "/flights/next"
        case .previous:
            return "/flights/previous"
        }
    }
    
    var type: GetFlightsType
    
    init(model: SearchFlightModel, type: GetFlightsType) {
        self.type = type
        super.init()
        if let departureId = model.departureAirportId,
           let arrivalId = model.arrivalAirportId,
           let date = model.dateOfDeparture {
            let params = GetFlightsParameters(departureAirportId: departureId,
                                              arrivalAirportId: arrivalId,
                                              dateOfDeparture: date,
                                              hasReturnFlight: model.hasReturnFlight)
            queryParams = params.queryParams
        }
    }
    
    func perform(completion: @escaping (Result<GetFlightsResponse, Error>) -> Void) {
        guard let encodedURLRequest = try? URLEncoding.default.encode(self, with: parameters?.dictionary) else {
            return
        }
        AF.request(encodedURLRequest).validate().responseDecodable(of: GetFlightsResponse.self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct GetFlightsResponse: Decodable {
    let dateOfDeparture: String
    let flights: [Flight]
    let departureAirport: Airport
    let arrivalAirport: Airport
}

struct Flight: Decodable {
    let id: String
    let flightDuration: String
    let timeOfDeparture: String
    let timeOfArrival: String
    let numberOfAvailableSeats: Int?
    let lowestPriceWithTax: String
    let flightNumber: String
    
    var availableSeats: Int {
        return numberOfAvailableSeats ?? 100 // fallback to static 100
    }
}

