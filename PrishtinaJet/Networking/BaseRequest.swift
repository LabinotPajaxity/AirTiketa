//
//  BaseRequest.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 3/10/21.
//

import Foundation
import Alamofire

enum ApiError: Error,LocalizedError, Equatable {
    case noData
    case cannotDecode
    case serverError(message: String)
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Empty data"
        case .cannotDecode:
            return "Can not decode"
        case .serverError(let message):
            return message
        }
    }
}

class BaseRequest: URLRequestConvertible {
    private let baseUrlString = "https://api.dev.bemyticket.com"
    
    var api: String {
        return "/api"
    }
    
    var version: String {
        return "/v1"
    }
    
    var path: String {
        return "/"
    }
    
    var usesCleanBaseUrl = false
    
    var queryParams: String?
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var parameters: Encodable?
    
    var headers: HTTPHeaders? {
        return []
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = makeUrl() else {
            fatalError("Bad url")
        }
        var request = try URLRequest(url: url, method: method, headers: headers)
        if let parameters = parameters {
            let body = try? JSONSerialization.data(withJSONObject: parameters.dictionary, options: .prettyPrinted)
            request.httpBody = body
            print(request)
        }
        return request
    }
    
    private func makeUrl() -> URL? {
        var urlString = baseUrlString
        if usesCleanBaseUrl {
            urlString += path + (queryParams ?? "")
        }
        else {
            urlString += api + version + path + (queryParams ?? "")
        }
        return URL(string: urlString)
    }
}
