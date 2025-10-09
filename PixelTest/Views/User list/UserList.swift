//
//  UserList.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import SwiftUI

struct UserList: View {
  
  @StateObject var viewModel = UserListViewModel()
  
  var body: some View {
    
    NavigationStack {
      
      if let error = viewModel.error {
        Text("Error fetching users:\n\(error.localizedDescription)")
          .foregroundStyle(Color.red)
      }
      
      List(viewModel.users) { item in
        
        Text(item.displayName)
        
      }
      .task(id: viewModel.taskId) {
        await viewModel.updateUsers()
      }
      .refreshable {
        viewModel.taskId = .init()
      }
    }
    
  }
}

#Preview {
  // Inject mock user service before returning the previewed list
  InjectedValues[\.userFetchServiceProvider] = UserFetchServiceMock()
  return UserList()
}
