//
//  Endpoint.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import Combine

typealias JSONDictionary = [String: Any]

protocol Endpoint {
    var route: String { get }
    var params: JSONDictionary { get }
    var httpMethod: HttpMethod { get }
    //var encoding: Encoding //enum Encoding { case urlEncoded, jsonEncoded }
    
    func request<T: Codable>(with service: NetworkInitiable) -> AnyPublisher<T, ApiError>
}

extension Endpoint {
    func request<T: Codable>(with service: NetworkInitiable) -> AnyPublisher<T, ApiError> {
        var urlPath = ApiHelper.apiUrl + route
        
        switch httpMethod {
        case .get:
            if !(params.isEmpty) {
                urlPath.append(params.queryString)
            }
        default:
            break
        }
        
        guard let url = URL(string: urlPath) else {
            return Future { promise in
                promise(.failure(ApiError.invalidUrl))
            }
            .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        ApiHelper.setHeaders(to: &urlRequest)
        
        return service.requestPublisher(with: urlRequest)
    }
}
