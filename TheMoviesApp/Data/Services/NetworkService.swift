//
//  NetworkService.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: String, parameters: [String: Any]?) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL: String
    private let apiKey: String
    private let session: Session
    
    init(baseURL: String, apiKey: String, session: Session = Session.default) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: String, parameters: [String: Any]? = nil) async throws -> T {
        let url = baseURL + endpoint
        var params = parameters ?? [:]
        params["api_key"] = apiKey
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url, parameters: params)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
