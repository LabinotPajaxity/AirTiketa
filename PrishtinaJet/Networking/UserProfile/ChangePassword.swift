//
//  ChangePassword.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 5.5.22..
//

import Foundation
import Alamofire

private struct ChangePasswordParameters: Encodable {
    let oldPassword: String
    let newPassword: String
}

struct SuccessRequest: Decodable {}
struct FailRequestError: Decodable {
    let code: Int
    let status: String
    let message: String
}

enum Response : Decodable {
    case status200(SuccessRequest)
    case status400(FailRequestError)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = .status200(try container.decode(SuccessRequest.self))
        } catch {
            self = .status400(try container.decode(FailRequestError.self))
        }
    }
}

class ChangePassword: BaseRequest {

    override var path: String {
        return "/account/password"
    }
    override var method: HTTPMethod {
        return .post
    }
    override var headers: HTTPHeaders? {
        guard let accessToken = KeychainManager.shared.accessToken else {
            return []
        }
        
        return ["Authorization" : "Bearer " + accessToken ,  "Content-Type": "application/json"]
    }
    
    init(oldPassword: String, newPassword: String) {
        super.init()
        
        parameters = ChangePasswordParameters(oldPassword: oldPassword, newPassword: newPassword)
    }
    
    func perform(completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request(self).validate().response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
//                completion(.failure(error))
                self.handleError(from: response.data, error: error, completion: completion)
            }
        }
    }
    
    func handleError(from response: Data?, error: Error, completion: @escaping (Result<Void, Error>) -> Void) {
        if let data = response,
           let serverError = try? JSONDecoder().decode(FailRequestError.self, from: data) {
            completion(.failure(ApiError.serverError(message: serverError.message)))
        } else {
            completion(.failure(error))
        }
    }
}
