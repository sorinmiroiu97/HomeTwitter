//
//  Constants.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import UIKit

struct Constants {
    
    struct Char {
        static let questionMark = "?"
        static let equalSign = "="
        static let andSign = "&"
        static let atSign = "@"
        static let space = " "
        static let tab = "  "
        static let paddedArrow = "\(space)->\(space)"
    }
    
    struct Layout {
        static let spacing: CGFloat = 20
        static let smallSpacing: CGFloat = 10
    }
    
    struct SFSymbols {
        static let personFill = "person.circle.fill"
        static let closeFill = "xmark.circle.fill"
        static let scribble = "scribble"
    }
    
    struct Strings {
        static let handleInputPlaceholder = "Twitter handle"
        static let fetchDataBtnLbl = "Fetch data for twitter handle"
        static let userDataSubtitle = "Twitter user data"
        static let id = "id"
        static let name = "name"
        static let username = "username"
        static let location = "location"
        static let verifiedUser = "verified user"
        static let unverifiedUser = "unverified user"
        static let userProfileTitle = "User profile"
        static let error = "Error"
        static let unknownError = "unknown error"
    }
}

struct Colors {
    static let backgroundId = "background"
}
