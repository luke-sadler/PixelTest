//
//  UserBadgesView.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import SwiftUI

struct BadgesView: View {
  
  var userBadges: UserBadges
  
  @ViewBuilder
  private var itemCircle: some View {
    Circle()
      .frame(width: 10, height: 10)
  }
  
  var body: some View {
    HStack {
      
      itemCircle
        .foregroundStyle(Color.yellow)
      Text("\(userBadges.gold)")
        .padding(.trailing, 5)
      
      itemCircle
        .foregroundStyle(Color.gray)
      Text("\(userBadges.silver)")
        .padding(.trailing, 5)
      
      itemCircle
        .foregroundStyle(Color.brown)
      Text("\(userBadges.bronze)")
      
      Spacer()
      
    }
  }
}
