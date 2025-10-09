//
//  UserFetchServiceImpl.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

class UserFetchServiceImpl: UserFetchService {
  
  @Injected(\.networkingServiceProvider) private var networkingService: NetworkingService
  
  func fetchTopUserList() async throws -> [User] {
    
    let userEndpoint = "https://api.stackexchange.com/2.2/users?page=1&pagesize=20&order=desc&sort=reputation&site=stackoverflow"
    // safe to force unwrap as we know this url is good
    let url = URL(string: userEndpoint)!
    let request = URLRequest(url: url)
    let response: UserFetchResponse = try await networkingService.makeRequest(request)
    return response.items
  }
}
