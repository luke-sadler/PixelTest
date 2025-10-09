//
//  AccountManagementImpl.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

/// Here we would otherwise have real api calls to mutate a following list in a backend.

class AccountManagementImpl: AccountManagementService {
  
  func followUser(_ user: User) async throws {
    print("Not implemented")
  }
  
  func unfollowUser(_ user: User) async throws {
    print("Not implemented")
  }

  func fetchFollowedUsers() async throws -> [Int] {
    print("Not implemented")
    return []
  }
  
}
