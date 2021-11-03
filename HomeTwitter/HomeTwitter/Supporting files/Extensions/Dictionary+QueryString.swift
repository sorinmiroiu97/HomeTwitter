//
//  Dictionary+QueryString.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output: String = Constants.Char.questionMark
        for (key, value) in self {
            output += "\(key)" + Constants.Char.equalSign + "\(value)" + Constants.Char.andSign
        }
        output = String(output.dropLast())
        return output.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? output
    }
}
