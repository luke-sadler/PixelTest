//
//  UserListViewModel.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
  
  @Injected(\.userFetchServiceProvider) private var userFetchingService: UserFetchService

  @Published var taskId = UUID()
  @Published var users: [User] = []
  @Published var error: Error?
  
  @MainActor
  func updateUsers() async {
    
    do {
      let users = try await userFetchingService.fetchTopUserList()
      self.users = users
    } catch let error {
      self.error = error
    }
  }
  
}
