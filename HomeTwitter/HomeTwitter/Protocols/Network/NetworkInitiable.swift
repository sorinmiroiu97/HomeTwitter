//
//  NetworkInitiable.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import Combine

protocol NetworkInitiable: AnyObject {
    func requestPublisher<T: Codable>(with request: URLRequest) -> AnyPublisher<T, ApiError>
}
