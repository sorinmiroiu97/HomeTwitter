//
//  UserProfileViewModelTests.swift
//  HomeTwitterTests
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import XCTest
import Combine
@testable import HomeTwitter

final class UserProfileViewModelTests: XCTestCase {
    
    private var viewModel: UserProfileViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables.removeAll()
    }
    
    func testFetchTimelineDataWithSuccess() {
        viewModel = UserProfileViewModel(webservice: MockService(result: .success(UserProfileMock.timeline)),
                                         with: MainViewMock.userData)
        
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.fetchRecentTweets()
        
        let exp = expectationFrom(publisher: viewModel.$userTweetTimeline,
                                  cancellables: &cancellables) { (timeline: UserTweetTimeline?) in
            XCTAssertNotNil(timeline?.data)
            XCTAssertNil(timeline?.errors)
        }
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func testFetchTimelineErrorWithSuccess() {
        viewModel = UserProfileViewModel(webservice: MockService(result: .success(UserProfileMock.errorTimeline)),
                                         with: MainViewMock.userData)
        
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.fetchRecentTweets()
        
        let exp = expectationFrom(publisher: viewModel.$userTweetTimeline,
                                  cancellables: &cancellables) { (timeline: UserTweetTimeline?) in
            XCTAssertNil(timeline?.data)
            XCTAssertNotNil(timeline?.errors)
        }
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func testFetchTimelineWithError() {
        viewModel = UserProfileViewModel(webservice: MockService<UserTweetTimeline>(result: .failure(.message(message: UserProfileMock.errorMessage))),
                                             with: MainViewMock.userData)
        
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.fetchRecentTweets()
        
        let exp = expectationFrom(publisher: viewModel.$error,
                                  cancellables: &cancellables) { (error: ApiError?) in
            XCTAssertEqual(error?.errorMessage, UserProfileMock.errorMessage)
            XCTAssertNil(viewModel.userTweetTimeline)
        }
        
        wait(for: [exp], timeout: 0.5)
    }
}
