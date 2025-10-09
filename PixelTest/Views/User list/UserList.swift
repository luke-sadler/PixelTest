//
//  UserList.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import SwiftUI

struct UserList: View {
  
  @StateObject var viewModel = UserListViewModel()
  
  var body: some View {
    
    NavigationStack {
      
      if let error = viewModel.error {
        Text("Error fetching users:\n\(error.localizedDescription)")
          .foregroundStyle(Color.red)
      }
      
      List(viewModel.users) { item in
        
        UserRowView(user: item,
                    follows: viewModel.isUserFollowed(item),
                    tappedFollow: {
          await viewModel.followUser(item)
        },
                    tappedUnfollow: {
          await viewModel.unfollowUser(item)
        })
        
      }
      .selectionDisabled()
      .task(id: viewModel.taskId) {
        await viewModel.updateUsers()
        await viewModel.fetchFollowedUsers()
      }
      .refreshable {
        viewModel.taskId = .init()
      }
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
