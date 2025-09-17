//
//
//  DetailMyBookings.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 23.8.21..
//

import Foundation
import Alamofire

class DetailMyBookingServices {
    
    static let instance = DetailMyBookingServices()
    
    private let baseUrl = "https://api.dev.bemyticket.com/api/stripe/session-status"
    
    var headers: HTTPHeaders? {
        guard let accessToken = KeychainManager.shared.accessToken else {
            return []
        }
        return ["Authorization" : "Bearer " + accessToken]
    }
    
    // 🔹 Funksioni i parë: merr booking nga session
    func getBookingFromSession(sessionId: String, completion: @escaping (Result<ReservationDetailModel, Error>) -> Void) {
        
        let url = "\(baseUrl)?session_id=\(sessionId)"
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: ResercationFinal.self) { response in
                switch response.result {
                case .success(let booking):
                    // ✅ marrim reservationId
                    let reservationId = String(booking.reservationId)

                    self.listOfMyBooking(id: reservationId) { result in
                        switch result {
                        case .success(let reservationDetail):
                            completion(.success(reservationDetail))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }

                    
                case let .failure(error):
                    print("❌ API error: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func listOfMyBooking(id: String, completion: @escaping (Result<ReservationDetailModel, Error>) -> Void) {
        AF.request(URL_DETAIL_RESERVATION + id, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: ReservationDetailModel.self) { response in
                switch response.result {
                case .success(let booking):
                    completion(.success(booking))
                case let .failure(error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
}
