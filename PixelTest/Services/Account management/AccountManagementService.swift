//
//  AccountManagementService.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

@MainActor
protocol AccountManagementService {
  
  /// Pass in user you want to follow
  func followUser(_ user: User) async throws
  
  /// Pass in user that you want to stop following
  func unfollowUser(_ user: User) async throws
  
  /// Fetch a list of user IDs that you are currently following
  func fetchFollowedUsers() async throws -> [Int]
  
}
