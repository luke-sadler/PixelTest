//
//  UserBadges.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

/// Badges the user has obtained for their community contributions
struct UserBadges: Decodable {
  let bronze: Int
  let silver: Int
  let gold: Int
}
