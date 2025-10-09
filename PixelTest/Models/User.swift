//
//  User.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

/// A StackOverflow user. A basic, stripped down object for the bare purpose of what this app needs
struct User: Decodable, Identifiable {
  
  var id: Int { accountId }
  
  let accountId: Int
  let badgeCounts: UserBadges
  let displayName: String
  let profileImage: String
  let creationDate: Int
}

extension User {
  
  var presentableCreationDate: String {
    
    let created = Date(timeIntervalSince1970: TimeInterval(creationDate))
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .none
    dateFormatter.dateStyle = .short
    
    return dateFormatter.string(from: created)
    
  }
  
  var profileImageUrl: URL? {
    URL(string: profileImage)
  }
  
}
