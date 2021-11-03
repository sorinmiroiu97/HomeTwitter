//
//  MainViewModelTests.swift
//  HomeTwitterTests
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import XCTest
import Combine
@testable import HomeTwitter

final class MainViewModelTests: XCTestCase {
    
    private var viewModel: MainViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables.removeAll()
    }
    
    func testFetchUserDataWithSuccess() {
        viewModel = MainViewModel(webservice: MockService(result: .success(MainViewMock.dataUserResponse)))
        
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.getTwitterUser(from: MainViewMock.dummyUserHandle)
        
        let exp = expectationFrom(publisher: viewModel.$userPublisher,
                                  cancellables: &cancellables) { (user: UserResponse?) in
            XCTAssertNotNil(user?.data)
            XCTAssertNil(user?.errors)
        }
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func testFetchErrorDataWithSuccess() {
        viewModel = MainViewModel(webservice: MockService(result: .success(MainViewMock.errorUserResponse)))
        
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.getTwitterUser(from: MainViewMock.dummyUserHandle)
        
        let exp = expectationFrom(publisher: viewModel.$userPublisher,
                                  cancellables: &cancellables) { (user: UserResponse?) in
            XCTAssertNotNil(user?.errors?.first)
            XCTAssertNil(user?.data)
        }
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func testFetchDataWithError() {
        viewModel = MainViewModel(webservice: MockService<UserResponse>(result: .failure(.message(message: MainViewMock.errorMessage))))
        
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.getTwitterUser(from: MainViewMock.dummyUserHandle)
        
        let exp = expectationFrom(publisher: viewModel.$error,
                                  cancellables: &cancellables) { (error: ApiError?) in
            XCTAssertEqual(error?.errorMessage, MainViewMock.errorMessage)
            XCTAssertNil(viewModel.userPublisher)
        }
        
        wait(for: [exp], timeout: 0.5)
    }
}
