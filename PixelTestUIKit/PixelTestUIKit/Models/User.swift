//
//  User.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import UIKit

/// A StackOverflow user. A basic, stripped down object for the bare purpose of what this app needs
struct User: Decodable {
  
  let accountId: Int
  let badgeCounts: UserBadges
  /// Raw formatted display name of user. When presenting, use ``presentableDisplayName`` to ensure formatting is correct.
  let displayName: String
  let profileImage: String
  let creationDate: Int
}

extension User {
  
  var presentableCreationDate: String {
    
    let created = Date(timeIntervalSince1970: TimeInterval(creationDate))
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .none
    dateFormatter.dateStyle = .medium
    
    return dateFormatter.string(from: created)
    
  }
  
  var profileImageUrl: URL? {
    URL(string: profileImage)
  }
  
  /// Ensures display name is formatted correctly.
  var presentableDisplayName: String {
    
    // user names come back from SO in encoded format so accents dont show correctly, as noticed with user "Christian C. Salvad&#243;"
    
    // Quite CPU intensive to do the html formatting below so make sure its actually needed.
    guard displayName.contains("&#"),
          let nameData = displayName.data(using: .utf8) else {
      return displayName
    }
    
    do {
      
      return try NSAttributedString(data: nameData,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
      .string
      
    } catch {
      return displayName
    }
    
  }
  
}
