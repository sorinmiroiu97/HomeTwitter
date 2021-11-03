//
//  MainViewMock.swift
//  HomeTwitterTests
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
@testable import HomeTwitter

struct MainViewMock {
    
    static let dummyUserHandle = "user"
    
    static let errorMessage = "error message"
    
    static var userData: UserResponse.UserResponseData {
        UserResponse.UserResponseData(
            id: "12354",
            name: "test name",
            userName: "test_username",
            description: "description bio",
            profileImageUrl: "dummy img url",
            verified: false,
            protected: nil,
            location: "New York",
            url: nil,
            createdAt: nil
        )
    }
    
    static var errorData: UserResponse.UserResponseError {
        UserResponse.UserResponseError(
            parameter: "test",
            value: "value",
            detail: "error message",
            title: "title"
        )
    }
    
    static var dataUserResponse: UserResponse {
        UserResponse(
            title: nil, type: nil,
            detail: nil, status: nil,
            data: userData,
            errors: nil
        )
    }
    
    static var errorUserResponse: UserResponse {
        UserResponse(
            title: nil, type: nil,
            detail: nil, status: nil,
            data: nil,
            errors: [errorData]
        )
    }
}
