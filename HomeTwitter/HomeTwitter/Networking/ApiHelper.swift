//
//  ApiHelper.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation

struct ApiHelper {
    
    enum ApiEnvironment {
        case dev
        case live
        
        static var environment: ApiEnvironment {
            #if DEBUG
            return .dev
            #else
            return .live
            #endif
        }
    }
    
    static var apiUrl: String {
        switch ApiEnvironment.environment {
        case .dev, .live:
            //since we've only got access to 1 url, for this demo it's gonna be
            //the same one for both sandbox and production endpoints
            return "https://api.twitter.com/2"
        }
    }
    
    //to actually grab valid api keys create a free twitter developer account
    struct Keys {
        static let apiKey = "api_key_from_twitter_here"
        static let apiSecretKey = "api_secret_key_from_twitter_here"
        static let bearerToken = "bearer_token_from_twitter_here"
    }
    
    static var headers: [String: String] {
        return [
            "Authorization": "Bearer\(Constants.Char.space)\(Keys.bearerToken)",
            "Accept": "*/*"
        ]
    }
    
    static func setHeaders(to urlRequest: inout URLRequest) {
        headers.forEach { args in
            let (key, value) = args
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
