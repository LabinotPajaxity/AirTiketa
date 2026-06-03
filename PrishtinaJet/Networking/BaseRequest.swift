//
//  BaseRequest.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/10/21.
//

import Foundation
import Alamofire

enum ApiError: Error, LocalizedError, Equatable {
    case noData
    case cannotDecode
    case serverError(message: String)
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Empty data"
        case .cannotDecode:
            return "Cannot decode"
        case .serverError(let message):
            return message
        }
    }
}

class BaseRequest: URLRequestConvertible {
    
    /// Uses current environment base URL from APIConfig
    private var baseUrlString: String {
        return BASE_URL
    }
    
    var api: String { return "/api" }
    var version: String { return "/v1" }
    var path: String { return "/" }
    var usesCleanBaseUrl = false
    var queryParams: String?
    
    var method: HTTPMethod { return .get }
    var parameters: Encodable?
    
	var headers: HTTPHeaders? {
		return [
			"Accept": "application/json",
			"User-Agent": "Airtiketa-iOS"
		]
	}
    
    func asURLRequest() throws -> URLRequest {
        guard let url = makeUrl() else {
            fatalError("Bad URL")
        }
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        
        // Encode parameters as JSON if provided
        if let parameters = parameters {
            let body = try? JSONSerialization.data(withJSONObject: parameters.dictionary, options: .prettyPrinted)
            request.httpBody = body
            print(request)
        }
        
        return request
    }
    
	private func makeUrl() -> URL? {

		var components = URLComponents()

		components.scheme = "https"
		components.host = "web-api.airtiketa.eu"
		components.path = "/api/v1\(path)"

		if let queryParams {
			components.percentEncodedQuery = queryParams.replacingOccurrences(of: "?", with: "")
		}

		return components.url
	}
}
