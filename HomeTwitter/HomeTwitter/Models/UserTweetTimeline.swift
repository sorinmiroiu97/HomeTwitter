//
//  UserTweetTimeline.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation

/**
 The response for the user tweet timeline by id endpoint.
 
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
     "data": [
         {
             "id": "8123y59812734",
             "text": "Text here…"
         },
        ...
    ]
 }
 
 Failure:
 {
     "errors": [
         {
             "message": "The `id` query parameter value [asdf] does not match ^[0-9]{1,19}$"
         }
     ],
     "title": "Invalid Request",
     "detail": "One or more parameters to your request was invalid.",
     "type": "https://api.twitter.com/2/problems/invalid-request"
 }
 */
struct UserTweetTimeline: Codable {
    let title: String?
    let detail: String?
    let type: String?
    
    let data: [UserTweetTimelineData]?
    let errors: [UserTweetTimelineError]?
}

extension UserTweetTimeline {
    struct UserTweetTimelineData: Codable, Identifiable {
        let id: String?
        let text: String?
    }
    
    struct UserTweetTimelineError: Codable {
        let parameter: String?
        let value: String?
        let detail: String?
        let title: String?
    }
}
