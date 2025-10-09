//
//  UserList.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import SwiftUI

struct UserList: View {
  
  // Only set to true on first launch when data is initially pulling. shows activity spinner.
  @State var showLoading: Bool = false
  @StateObject var viewModel = UserListViewModel()
  
  var body: some View {
    
    NavigationStack {
      
      if let error = viewModel.error {
        Text("Error fetching users:\n\(error.localizedDescription)")
          .foregroundStyle(Color.red)
      }
      
      if showLoading {
        ProgressView()
      }
      
      List(viewModel.users, id: \.accountId) { item in
        
        UserRowView(user: item,
                    follows: viewModel.isUserFollowed(item),
                    tappedFollow: {
          await viewModel.followUser(item)
        },
                    tappedUnfollow: {
          await viewModel.unfollowUser(item)
        })
        .selectionDisabled()
        
      }
      .task(id: viewModel.taskId) {
        await viewModel.updateUsers()
        await viewModel.fetchFollowedUsers()
        showLoading = false
      }
      .refreshable {
        viewModel.taskId = .init()
      }
      .onAppear(perform: {
        showLoading = true
      })
      .navigationTitle("Top StackOverflow Users")
      .navigationBarTitleDisplayMode(.inline)
    }
    
  }
}

#Preview {
  // Inject mock user service before returning the previewed list as to not hammer api during dev
  InjectedValues[\.userFetchServiceProvider] = UserFetchServiceMock()
  return UserList()
}
