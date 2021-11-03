//
//  Unwrap.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content
    
    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }
    
    var body: some View {
        value.map(contentProvider)
    }
}


struct Unwrap_Previews: PreviewProvider {
    private static let optionalUser: String? = "dummy user"
    static var previews: some View {
        Unwrap(optionalUser) { (user: String) in
            Text(user)
        }
    }
}
