//
//  UserProfileView.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import SwiftUI
import Kingfisher

struct UserProfileView: View, ViewInitiable {
    
    typealias ViewModel = UserProfileViewModel
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var isErrorPresented = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(viewModel.model.name ?? Constants.Strings.userProfileTitle)
                .navigationBarItems(trailing: dismissBtn)
        }
        .onReceive(viewModel.$error) { (error: ApiError?) in
            withAnimation {
                isErrorPresented = error != nil
            }
        }
        .alert(isPresented: $isErrorPresented) {
            Alert(title: Text(Constants.Strings.error), message: Text(viewModel.error?.errorMessage ?? Constants.Strings.unknownError))
        }
        .onAppear { [weak viewModel] in
            viewModel?.fetchRecentTweets()
        }
    }
    
    private var content: some View {
        BackgroundView(backgroundContent: {
            Color(Colors.backgroundId)
        }, content: {
            List {
                userProfileSection
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else {
                    tweetsSection
                }
            }
            .listStyle(.insetGrouped)
        })
    }
    
    private var userProfileSection: some View {
        Section {
            VStack(spacing: Constants.Layout.spacing) {
                bioThumbnailView
                userInfoView
            }
        }
    }
    
    private var bioThumbnailView: some View {
        HStack(spacing: Constants.Layout.smallSpacing) {
            Unwrap(viewModel.model.profileImageUrl) { (urlPath: String) in
                KFImage(URL(string: urlPath))
                    .resizable()
                    .placeholder {
                        Image(systemName: Constants.SFSymbols.personFill)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: Constants.Layout.spacing * 2, height: Constants.Layout.spacing * 2)
                    }
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: Constants.Layout.spacing * 2, height: Constants.Layout.spacing * 2)
            }
            Unwrap(viewModel.model.description) { (description: String) in
                Text(description)
            }
        }
    }
    
    private var userInfoView: some View {
        VStack(alignment: .leading) {
            Unwrap(viewModel.model.id) { (id: String) in
                Text("\(Constants.Strings.id)\(Constants.Char.paddedArrow)\(id)")
            }
            Unwrap(viewModel.model.name) { (name: String) in
                Text("\(Constants.Strings.name)\(Constants.Char.paddedArrow)\(name)")
            }
            Unwrap(viewModel.model.userName) { (userName: String) in
                Text("\(Constants.Strings.username)\(Constants.Char.paddedArrow)\(Constants.Char.atSign)\(userName)")
            }
            Unwrap(viewModel.model.location) { (location: String) in
                Text("\(Constants.Strings.location)\(Constants.Char.paddedArrow)\(location)")
            }
            Unwrap(viewModel.model.verified) { (verified: Bool) in
                Text(verified ? Constants.Strings.verifiedUser : Constants.Strings.unverifiedUser)
            }
        }
    }
    
    @ViewBuilder
    private var tweetsSection: some View {
        if let timelineData = viewModel.userTweetTimeline?.data {
            Section {
                Unwrap(viewModel.model.userName) { (userName: String) in
                    Text("\(Constants.Char.paddedArrow)\(userName)'s latest tweets \(Image(systemName: Constants.SFSymbols.scribble))")
                }
                .padding(.bottom, Constants.Layout.spacing)
                ForEach(timelineData) { timeline in
                    VStack(alignment: .leading, spacing: Constants.Layout.smallSpacing) {
                        Unwrap(timeline.id) { (id: String) in
                            Text(id)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Unwrap(timeline.text) { (text: String) in
                            Text(text)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private var dismissBtn: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: Constants.SFSymbols.closeFill)
                .font(.title2)
        }

    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: .init(webservice: MockService(result: .success(EmptyResponse())),
                                         with: UserResponse.UserResponseData(id: nil, name: nil, userName: nil, description: nil, profileImageUrl: nil, verified: nil, protected: nil, location: nil, url: nil, createdAt: nil)))
    }
}

