//
//  MockService.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import Combine

final class MockService<Model: Codable>: NetworkInitiable {
    
    let result: Result<Model?, ApiError>
    
    required init(result: Result<Model?, ApiError>) {
        self.result = result
    }
    
    func requestPublisher<T: Codable>(with request: URLRequest) -> AnyPublisher<T, ApiError> {
        Future { [weak self] promise in
            switch self?.result {
            case .failure(let error):
                promise(.failure(error))
            case .success(let model):
                if let model = model as? T {
                    promise(.success(model))
                } else {
                    fallthrough
                }
            default:
                promise(.failure(.unknown))
            }
        }.eraseToAnyPublisher()
    }
    
}
