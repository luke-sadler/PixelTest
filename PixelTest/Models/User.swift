//
//  User.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

struct User: Decodable, Identifiable {
  
  var id: Int { accountId }
  
  let accountId: Int
  let badgeCounts: UserBadges
  
  
}
