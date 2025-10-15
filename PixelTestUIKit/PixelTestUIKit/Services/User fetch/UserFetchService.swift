//
//  UserFetchService.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

enum UserFetchServiceError: Error {
  case userProfileUrlFailure
}

protocol UserFetchService {
  
  func fetchTopUserList() async throws -> [User]
  
  func fetchUserProfileImage(_ user: User) async throws -> Data
}
