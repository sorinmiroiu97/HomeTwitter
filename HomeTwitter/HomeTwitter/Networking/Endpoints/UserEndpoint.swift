//
//  UserEndpoint.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import Combine

enum UserEndpoint: Endpoint {
    
    case userHandle(user: String)
    case userTimelineTweets(userId: String)
    
    var route: String {
        switch self {
        case .userHandle(let user):
            return "/users/by/username/\(user)"
        case .userTimelineTweets(let userId):
            return "/users/\(userId)/tweets"
        }
    }
    
    var params: JSONDictionary {
        switch self {
        case .userHandle:
            return ["user.fields": "created_at,description,entities,id,location,name,profile_image_url,protected,url,username,verified,withheld"]
        case .userTimelineTweets:
            return ["max_results": 30]
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .userHandle, .userTimelineTweets:
            return .get
        }
    }
}
