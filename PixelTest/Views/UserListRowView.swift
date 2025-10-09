//
//  UserListRowView.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import SwiftUI

struct UserRowView: View {
  var user: User
  var follows: Bool
  var tappedFollow: () async -> Void
  var tappedUnfollow: () async -> Void
  
  var body: some View {
    
    HStack {
      AsyncImage(url: user.profileImageUrl) {
        $0.resizable()
      } placeholder: {
        ProgressView()
      }
      .frame(width: 60, height: 60)
      .clipShape(Circle())
      
      VStack(alignment: .leading) {
        Text(user.presentableDisplayName)
          .font(.title2)
        
        Text("Account created:")
          .font(.caption)
        Text(user.presentableCreationDate)
        
        BadgesView(userBadges: user.badgeCounts)
      }
      
      AsyncButton {
        if follows {
          await tappedUnfollow()
        } else {
          await tappedFollow()
        }
      } label: {
        if follows {
          Image(systemName: "heart.fill")
            .foregroundStyle(Color.red)
        } else {
          Image(systemName: "heart")
            .foregroundStyle(Color.red)
        }
        
      }
      
    }
  }
}
