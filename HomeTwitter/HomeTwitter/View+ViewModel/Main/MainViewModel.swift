//
//  MainViewModel.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject, ViewModelInitiable {
    
    typealias ModelObject = Any?
    
    let webservice: NetworkInitiable
    
    @Published private(set) var error: ApiError?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var userPublisher: UserResponse?
    
    var cancelables = Set<AnyCancellable>()
    
    required init(webservice: NetworkInitiable = NetworkService.shared,
                  with model: Any? = nil) {
        self.webservice = webservice
    }
    
    func getTwitterUser(from userHandle: String) {
        guard !(isLoading), !(userHandle.isEmpty) else { return }
        
        isLoading = true
        UserEndpoint.userHandle(user: userHandle).request(with: webservice)
            .sink { [weak self] (completion: Subscribers.Completion<ApiError>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                }
                self?.isLoading = false
            } receiveValue: { [weak self] (user: UserResponse) in
                self?.userPublisher = user
                //in case there's an error in the successful parse case we treat it here
                if let detail = user.detail {
                    self?.error = .message(message: detail)
                } else if let detailError = user.errors?.first?.detail {
                    self?.error = .message(message: detailError)
                }
            }.store(in: &cancelables)
    }
}
