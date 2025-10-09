//
//  AccountManagementMock.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

// Very basic list of account ids being stored locally in UserDefaults for rough-and-ready persistance

class AccountManagementMock: AccountManagementService {
  
  private let followsKey = "follows"
  private var defaults: UserDefaults {
    UserDefaults.standard
  }
  
  private var followedUserIds: [Int] {
    defaults.array(forKey: followsKey) as? [Int] ?? []
  }
  
  func followUser(_ user: User) async throws {
    var follows = followedUserIds
    
    if follows.contains(user.accountId) == false {
      follows.append(user.accountId)
    }
    
    defaults.set(follows, forKey: followsKey)
  }
  
  func unfollowUser(_ user: User) async throws {
    var follows = followedUserIds
    follows.removeAll(where: { $0 == user.accountId })
    defaults.set(follows, forKey: followsKey)
  }
  
  func fetchFollowedUsers() async throws -> [Int] {
    followedUserIds
  }
}
