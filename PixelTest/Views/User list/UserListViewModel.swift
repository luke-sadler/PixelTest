//
//  UserListViewModel.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import Combine

@MainActor
class UserListViewModel: ObservableObject {
  
  @Injected(\.userFetchServiceProvider) private var userFetchingService: UserFetchService
  @Injected(\.accountManagementServiceProvider) private var accountManagementService: AccountManagementService

  @Published var taskId = UUID()
  @Published var users: [User] = []
  @Published var error: Error?
  @Published var followedUsers = [Int]()
  
  func isUserFollowed(_ user: User) -> Bool {
    followedUsers.contains(user.accountId)
  }
  
  func fetchFollowedUsers() async {
    do {
      let followedUserIds = try await accountManagementService.fetchFollowedUsers()
      self.followedUsers = followedUserIds
    }
    catch let error {
      self.error = error
    }
  }
  
  func updateUsers() async {
    
    do {
      let users = try await userFetchingService.fetchTopUserList()
      self.users = users
    } catch let error {
      self.error = error
    }
  }

  func followUser(_ user: User) async {
    
    do {
      try await accountManagementService.followUser(user.accountId)
      await fetchFollowedUsers()
    } catch let error {
      self.error = error
    }
  }
  
  func unfollowUser(_ user: User) async {
    do {
      try await accountManagementService.unfollowUser(user.accountId)
      await fetchFollowedUsers()
    } catch let error {
      self.error = error
    }
  }
  
}
