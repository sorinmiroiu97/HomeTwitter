//
//  UserProfileViewModel.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import Combine

final class UserProfileViewModel: ObservableObject, ViewModelInitiable {
    
    typealias ModelObject = UserResponse.UserResponseData
    
    let webservice: NetworkInitiable
    let model: ModelObject
    
    @Published private(set) var error: ApiError?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var userTweetTimeline: UserTweetTimeline?
    
    var cancelables = Set<AnyCancellable>()
    
    required init(webservice: NetworkInitiable = NetworkService.shared,
                  with model: UserResponse.UserResponseData) {
        self.webservice = webservice
        self.model = model
    }
    
    func fetchRecentTweets() {
        guard !(isLoading) else { return }
        isLoading = true
        
        UserEndpoint.userTimelineTweets(userId: model.id ?? "").request(with: webservice)
            .sink { [weak self] (completion: Subscribers.Completion<ApiError>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                }
                self?.isLoading = false
            } receiveValue: { [weak self] (timeline: UserTweetTimeline) in
                self?.userTweetTimeline = timeline
                //in case there's an error in the successful parse case we treat it here
                if let detail = timeline.detail {
                    self?.error = .message(message: detail)
                } else if let detailError = timeline.errors?.first?.detail {
                    self?.error = .message(message: detailError)
                }
            }.store(in: &cancelables)
    }
}
