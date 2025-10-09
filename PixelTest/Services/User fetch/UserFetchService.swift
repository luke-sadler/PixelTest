//
//  UserFetchService.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

protocol UserFetchService {
  
  func fetchTopUserList() async throws -> [User]
  
}
