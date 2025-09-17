//
//  AlamofireWrapper.swift
//  PrishtinaJet
//
//  Created by Pajaziti Labinot on 9.9.21..
//


import Alamofire

private struct RefreshTokenParameters: Encodable {
    let grant_type: String
    let refresh_token: String
}

class RefreshToken: BaseRequest {
    override var path: String {
        return "/oauth/token"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var headers: HTTPHeaders? {
        return [
            HTTPHeader(name: "Authorization", value: "Basic cHJqZXRfY2xpZW50X2lkOnByamV0X3NlY3JldA=="),
            HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded")
        ]
    }
    
    init(grant_type: String, refresh_token: String) {
        super.init()
        usesCleanBaseUrl = true
        parameters = RefreshTokenParameters(grant_type: "refresh_token", refresh_token: KeychainManager.shared.accessRefreshToken!)
    }
    
    func perform(completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let encodedURLRequest = try? URLEncoding.default.encode(self, with: parameters?.dictionary) else {
            return
        }
        AF.request(encodedURLRequest).validate().responseDecodable(of: LoginResponse.self) { respone in
            switch respone.result {
                case .success(let response):
                    KeychainManager.shared.store(token: response.accessToken)
                    KeychainManager.shared.store(refreshToken: response.refreshToken)
                    KeychainManager.shared.store(tokenType: response.tokenType)
                    
                    print(response)
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
