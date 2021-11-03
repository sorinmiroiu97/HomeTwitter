//
//  HomeTwitterApp.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import SwiftUI

@main
struct HomeTwitterApp: App {
    
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: mainViewModel)
        }
    }
}
