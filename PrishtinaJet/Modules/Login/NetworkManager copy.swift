////
////  NetworkManager.swift
////  Capital
////
////  Created by Blerd Foniqi on 8/17/21.
////
//
//import Alamofire
//import Foundation
//import Reachability
//
//class NetworkManager {
//    private static let baseUrlString = "https://url"
//
//    static let reachability = try? Reachability()
//
//    fileprivate static func request(
//        path: String,
//        method: HTTPMethod,
//        parameters: [String: Any]? = nil,
//        result: @escaping (Result<Data?, Error>) -> Void
//    ) {
//        let urlString = String(format: "%@%@", baseUrlString, path)
//        guard let url = URL(string: urlString) else {
//            fatalError("Bad url")
//        }
//        if reachability?.connection != Reachability.Connection.unavailable {
//            let request = AF.request(
//                url,
//                method: method,
//                parameters: parameters,
//                encoding: JSONEncoding.default,
//                headers: headers()
//            ).validate()
//            request.responseData { response in
//                switch response.result {
//                case .success:
//                    result(.success(response.value))
//                case .failure(let error):
//                    if let statusCode = response.response?.statusCode, statusCode >= 400 {
//                        if statusCode == 401 {
//                            RefreshToken().perform { refreshResult in
//                                switch refreshResult {
//                                case .success:
//                                    NetworkManager.request(path: path,
//                                                           method: method,
//                                                           parameters: parameters,
//                                                           result: result)
//                                case .failure(let error):
//                                    result(.failure(error))
//                                }
//                            }
//                        }
//                        if let data = response.data {
//                            result(.failure(error))
//                        } else if statusCode >= 500 {
//                            result(.failure(error))
//                        } else {
//                            result(.failure(error))
//                        }
//                    } else {
//                        result(.failure(error))
//                    }
//                }
//            }
//        } else {
//            result(.failure(ApiError.noInternetConnection))
//        }
//    }
//
//    static func headers() -> HTTPHeaders {
//        var headers: HTTPHeaders = ["Accept": "application/json"]
//        if let token = KeychainManager.shared.accessToken {
//            headers["Authorization"] = token
//        }
//        return headers
//    }
//
//    fileprivate static func getRequest(
//        path: String,
//        parameters: [String: Any]? = nil,
//        result: @escaping (Result<Data?, Error>) -> Void
//    ) {
//        request(path: path, method: .get, parameters: parameters, result: result)
//    }
//
//    fileprivate static func postRequest(
//        path: String,
//        parameters: [String: Any]? = nil,
//        result: @escaping (Result<Data?, Error>) -> Void
//    ) {
//        request(path: path, method: .post, parameters: parameters, result: result)
//    }
//
//    fileprivate static func putRequest(
//        path: String,
//        parameters: [String: Any]? = nil,
//        result: @escaping (Result<Data?, Error>) -> Void
//    ) {
//        request(path: path, method: .put, parameters: parameters, result: result)
//    }
//
//    fileprivate static func deleteRequest(
//        path: String,
//        parameters: [String: Any]? = nil,
//        result: @escaping (Result<Data?, Error>) -> Void
//    ) {
//        request(path: path, method: .delete, parameters: parameters, result: result)
//    }
//
//    func cancelAllRequests(onCompletion: (() -> Void)? = nil) {
//        AF.session.getTasksWithCompletionHandler { sessionDataTask, uploadData, downloadData in
//            sessionDataTask.forEach { $0.cancel() }
//            uploadData.forEach { $0.cancel() }
//            downloadData.forEach { $0.cancel() }
//            onCompletion?()
//        }
//    }
//
//    private static func decode<T: Decodable>(from data: Data?, completion: @escaping (Result<T, Error>) -> Void) {
//        guard let data = data else {
//            completion(.failure(ApiError.noData))
//            return
//        }
//        do {
//            let decodedObject = try JSONDecoder().decode(T.self, from: data)
//            completion(.success(decodedObject))
//        } catch {
//            completion(.failure(error))
//        }
//    }
//}
//
//extension NetworkManager {
//    private static func getUserDetails(completion: @escaping (Result<UserDetails, Error>) -> Void) {
//        getRequest(path: "/auth/me") { result in
//            switch result {
//            case .success(let data):
//                self.decode(from: data, completion: completion)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    static func getUserDetails(completion: ((String) -> Void)? = nil) {
//        NetworkManager.getUserDetails { result in
//            switch result {
//            case .success(let userDetails):
//                try? UserDefaults.standard.set(object: userDetails, forKey: "userDetails")
//
//                completion?(userDetails.balance)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    static func setEmail(_ email: String, completion: @escaping (Result<(), Error>) -> Void) {
//        putRequest(path: "/user/client/private", parameters: ["email": email]) { result in
//
//        }
//    }
//
//    static func getTransactions(page: Int, size: Int = 10,
//                                completion: @escaping (Result<[Transaction], Error>) -> Void) {
//        getRequest(path: "/sampleurl") { result in
//            switch result {
//            case .success(let data):
//                self.decode(from: data, completion: completion)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//}
