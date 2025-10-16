//
//  FollowUserTests.swift
//  PixelTestTests
//
//  Created by luke on 09/10/2025.
//

import XCTest
@testable import PixelTestUIKit

@MainActor
class FollowUserTests: XCTestCase {
 
  override func setUpWithError() throws {
    // start with clean slate each test
    UserDefaults.standard.removeObject(forKey: "follows")
  }
  
  private var accountService: AccountManagementService {
    @Injected(\.accountManagementServiceProvider) var accountService: AccountManagementService
    return accountService
  }
  
  private func followList() async throws -> [Int] {
    try await accountService.fetchFollowedUsers()
  }
  
  func test_follow_unfollow_user() async throws {
   
    var follows: [Int] = []
    
    // check its empty
    follows = try await self.followList()
    XCTAssertEqual(follows.count, 0)
    
    // add user to list
    try await accountService.followUser(123)
    follows = try await self.followList()
    XCTAssertEqual(follows.count, 1)
    XCTAssertEqual(follows.first, 123)
    
    // remove user
    try await accountService.unfollowUser(123)
    follows = try await self.followList()
    XCTAssertEqual(follows.count, 0)
  }
}
