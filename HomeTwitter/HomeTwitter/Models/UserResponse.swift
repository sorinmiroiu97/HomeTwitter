//
//  UserResponse.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation

/**
 The response for the user by username endpoint.
 
 In case the bearer token is missing or is incorrect the response will come as follows:
 {
    "title": "Unauthorized",
    "type": "about:blank",
    "status": 401,
    "detail": "Unauthorized"
 }
 
 In case the bearer token is present and correct the response may come in two states:
 Successful:
 {
     "data": {
         "id": "261100416",
         "name": "Mark-E. Kretschmer",
         "username": "test123",
         ...
     }
 }
 
 Failure:
 {
     "errors": [
         {
             "parameter": "username",
             "resource_id": "test123asdfasdf",
             "value": "test123asdfasdf",
             "detail": "User has been suspended: [test123asdfasdf].",
             "title": "Forbidden",
             "resource_type": "user",
             "type": "https://api.twitter.com/2/problems/resource-not-found"
         }
     ]
 }
 */
struct UserResponse: Codable {
    let title: String?
    let type: String?
    let detail: String?
    let status: Int?
    
    let data: UserResponseData?
    let errors: [UserResponseError]?
}

extension UserResponse {
    struct UserResponseData: Codable, Identifiable {
        let id: String?
        let name: String?
        let userName: String?
        let description: String?
        let profileImageUrl: String?
        let verified: Bool?
        let protected: Bool?
        let location: String?
        let url: String?
        let createdAt: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case userName = "username"
            case description
            case profileImageUrl = "profile_image_url"
            case verified
            case protected
            case location
            case url
            case createdAt = "created_at"
        }
    }
    
    struct UserResponseError: Codable {
        let parameter: String?
        let value: String?
        let detail: String?
        let title: String?
    }
}
