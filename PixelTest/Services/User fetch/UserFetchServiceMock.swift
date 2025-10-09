//
//  UserFetchServiceMock.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

class UserFetchServiceMock: UserFetchService {
  
  func fetchTopUserList() async throws -> [User] {
    
    [
      User(accountId: 11683,
           badgeCounts: .init(bronze: 9338, silver: 9301, gold: 892),
           displayName: "Jon Skeet",
           profileImage: "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=256&d=identicon&r=PG",
           creationDate: 1222430705),
      User(accountId: 4243,
           badgeCounts: .init(bronze: 5724, silver: 4780, gold: 568),
           displayName: "VonC",
           profileImage: "https://i.sstatic.net/I4fiW.jpg?s=256",
           creationDate: 1221344553)
    ]
  }
}
