//
//  UserProfileMock.swift
//  HomeTwitterTests
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
@testable import HomeTwitter

struct UserProfileMock {
    
    static let errorMessage = "error message"
    
    static var timelineDatas: [UserTweetTimeline.UserTweetTimelineData] {
        let data = UserTweetTimeline.UserTweetTimelineData(id: "1234", text: "tweet text")
        return Array(repeating: data, count: 10)
    }
    
    static var timelineError: UserTweetTimeline.UserTweetTimelineError {
        UserTweetTimeline.UserTweetTimelineError(
            parameter: "test",
            value: "value",
            detail: "error message",
            title: "title"
        )
    }
    
    static var timeline: UserTweetTimeline {
        UserTweetTimeline(
            title: nil, detail: nil,
            type: nil,
            data: timelineDatas,
            errors: nil
        )
    }
    
    static var errorTimeline: UserTweetTimeline {
        UserTweetTimeline(
            title: nil, detail: nil,
            type: nil,
            data: nil,
            errors: [timelineError]
        )
    }
}
