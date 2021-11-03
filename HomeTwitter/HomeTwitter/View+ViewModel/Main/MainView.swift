//
//  MainView.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import SwiftUI

struct MainView: View, ViewInitiable {
    
    typealias ViewModel = MainViewModel
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var twitterHandleText = ""
    @State private var isUserProfilePresented = false
    @State private var isErrorPresented = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle(Constants.Strings.handleInputPlaceholder)
                .onReceive(viewModel.$error) { (error: ApiError?) in
                    withAnimation {
                        isErrorPresented = error != nil
                    }
                }
                .alert(isPresented: $isErrorPresented) {
                    Alert(title: Text(Constants.Strings.error), message: Text(viewModel.error?.errorMessage ?? Constants.Strings.unknownError))
                }
                .sheet(isPresented: $isUserProfilePresented) {
                    Unwrap(viewModel.userPublisher?.data) { (data: UserResponse.UserResponseData) in
                        UserProfileView(viewModel: .init(with: data))
                    }
                }
        }
    }
    
    private var content: some View {
        BackgroundView(backgroundContent: {
            Color(Colors.backgroundId)
        }, content: {
            VStack(alignment: .leading, spacing: Constants.Layout.spacing) {
                handleInput
                userInfoView
                fetchBtn
                Spacer()
            }
            .padding()
        })
    }
    
    private var handleInput: some View {
        TextField(Constants.Strings.handleInputPlaceholder, text: $twitterHandleText, onCommit: {
            onFetchBtnPressed()
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var fetchBtn: some View {
        Button(action: {
            onFetchBtnPressed()
        }, label: {
            HStack {
                Spacer()
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text(Constants.Strings.fetchDataBtnLbl)
                            .font(.title3)
                }
                Spacer()
            }
        })
    }
    
    private var userInfoView: some View {
        Unwrap(viewModel.userPublisher?.data) { (userData: UserResponse.UserResponseData) in
            VStack(alignment: .leading) {
                Text(Constants.Strings.userDataSubtitle)
                    .padding(.bottom, Constants.Layout.smallSpacing)
                Unwrap(userData.id) { (id: String) in
                    Text("\(Constants.Strings.id)\(Constants.Char.paddedArrow)\(id)")
                }
                Unwrap(userData.name) { (name: String) in
                    Text("\(Constants.Strings.name)\(Constants.Char.paddedArrow)\(name)")
                }
                Unwrap(userData.userName) { (userName: String) in
                    Text("\(Constants.Strings.userProfileTitle)\(Constants.Char.paddedArrow)\(Constants.Char.atSign)\(userName)")
                        .padding(.bottom, Constants.Layout.spacing)
                    Button(action: {
                        isUserProfilePresented = true
                    }, label: {
                        HStack {
                            Spacer()
                            Label(title: {
                                Text("\(Constants.Char.atSign)\(userName)")
                            },
                            icon: {
                                Image(systemName: Constants.SFSymbols.personFill)
                            })
                            Spacer()
                        }
                    })
                }
            }
        }
    }
    
    private func onFetchBtnPressed() {
        viewModel.getTwitterUser(from: twitterHandleText)
        resignKeyboard()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init(webservice: MockService(result: .success(EmptyResponse()))))
    }
}
