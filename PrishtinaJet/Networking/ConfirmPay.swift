//
//  ConfirmPay.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 14.9.21..
//

import Foundation
import Alamofire

struct PaymentData: Encodable {
    let travelers: [TravelersPayment]
    let contactNumber: String?
    let source: String
    
    let fullName: String?
    let email: String?
    let paymentType: String?
}
struct TravelersPayment:Encodable {
    let name: String
    let surname: String
    let dateOfBirth: String
    let ageCategory: String
    let gender: String
    let departureFlightId: String
    let returnFlightId: String?
}


class Payment: BaseRequest {
    
    
    override var path: String {
        return "/reservations/checkout"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var headers: HTTPHeaders? {
        return [  "Content-Type": "application/json"]
    }
    
    let viewModelToken = RefreshTokenViewModel()

    
    init(viewModel: PassengersViewModel) {
        super.init()
        
            var travellers = [TravelersPayment]()
            let departureFlightId = viewModel.model.departureFlight.id
            let returnFlightId = viewModel.model.returnFlight?.id
    
            for passenger in viewModel.model.passengers {
                let traveller = TravelersPayment(
                    name: passenger.name!,
                    surname: passenger.surname!,
                    dateOfBirth: passenger.birthday!,
                    ageCategory: passenger.type.title,
                    gender: passenger.sex!,
                    departureFlightId: departureFlightId,
                    returnFlightId: returnFlightId)
                travellers.append(traveller)
            }
        let fullName = KeychainManager.shared.accessUsername
        let email = KeychainManager.shared.accessEmail
        
        let paymentData = PaymentData(travelers: travellers, contactNumber: UserDefaults.standard.getcontactNumber(), source: "IOS",fullName: fullName, email: email, paymentType: UserDefaults.standard.getPaymentType())
            parameters = paymentData
            print(paymentData)
        }
    
    func perform(completion: @escaping (Result<PaymentResponse, Error>) -> Void) {
        AF.request(self).validate().responseDecodable(of: PaymentResponse.self) { respone in
            switch respone.result {
                case .success(let response):
                    print(response)
                    completion(.success(response))
                case .failure(let error):
                    
                    completion(.failure(error))
            }
        }
    }
}
