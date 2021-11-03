//
//  ResignKeyboard.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import SwiftUI

extension View {
    /**
     Resigns the keyboard on iOS and ipadOS.
     */
    func resignKeyboard() {
        #if os(iOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}
