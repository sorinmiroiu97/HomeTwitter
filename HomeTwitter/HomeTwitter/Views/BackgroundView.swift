//
//  BackgroundView.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import SwiftUI

struct BackgroundView<Content: View, BackgroundContent: View>: View {
    
    private let backgroundContent: () -> BackgroundContent
    private let content: () -> Content
    
    init(@ViewBuilder backgroundContent: @escaping () -> BackgroundContent,
                      @ViewBuilder content: @escaping () -> Content) {
        self.backgroundContent = backgroundContent
        self.content = content
    }
    
    init(backgroundViewColor: UIColor?,
         @ViewBuilder content: @escaping () -> Content) where BackgroundContent == Color {
        self.backgroundContent = {
            Color(backgroundViewColor ?? .clear)
        }
        self.content = content
    }
    
    var body: some View {
        backgroundView
    }
    
    private var backgroundView: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                backgroundContent()
                    .ignoresSafeArea(.all, edges: .all)
                content()
            } else {
                backgroundContent()
                    .edgesIgnoringSafeArea(.all)
                content()
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    
    private static let colors: [UIColor] = [.black, .white]
    
    static var previews: some View {
        Group {
            ForEach(0..<colors.count, id: \.self) { (uiColorIndex: Int) in
                TabView {
                    firstView(with: uiColorIndex)
                        .tabItem {
                            VStack {
                                Image(systemName: "info.circle")
                                Text("First")
                            }
                        }
                    secondView(with: uiColorIndex)
                        .tabItem {
                            VStack {
                                Image(systemName: "info.circle")
                                Text("Second")
                            }
                        }
                }
            }
        }
    }
    
    static func firstView(with uiColorIndex: Int) -> some View {
        NavigationView {
            BackgroundView {
                Color(colors[uiColorIndex])
            } content: {
                Text("text here")
                    .background(Color(UIColor.red))
            }
            .navigationBarTitle("Nav bar", displayMode: .inline)
        }
    }
    
    static func secondView(with uiColorIndex: Int) -> some View {
        NavigationView {
            BackgroundView(backgroundViewColor: colors[uiColorIndex]) {
                Text("text here")
                    .background(Color(UIColor.red))
            }
            .navigationBarTitle("Nav bar", displayMode: .inline)
        }
    }
}
