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
  
  func followUser(_ accountId: Int) async throws {
    var follows = followedUserIds
    
    if follows.contains(accountId) == false {
      follows.append(accountId)
    }
    
    defaults.set(follows, forKey: followsKey)
  }
  
  func unfollowUser(_ accountId: Int) async throws {
    var follows = followedUserIds
    follows.removeAll(where: { $0 == accountId })
    defaults.set(follows, forKey: followsKey)
  }
  
  func fetchFollowedUsers() async throws -> [Int] {
    followedUserIds
  }
}
