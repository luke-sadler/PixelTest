//
//  UserFetchServiceImpl.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

class UserFetchServiceImpl: UserFetchService {
  
  @Injected(\.networkingServiceProvider) private var networkingService: NetworkingService

  let imageCache: URLCache = .init(memoryCapacity: 10 * 1024 * 1024,
                                   diskCapacity: 0)
  
  func fetchTopUserList() async throws -> [User] {
    
    let userEndpoint = "https://api.stackexchange.com/2.2/users?page=1&pagesize=20&order=desc&sort=reputation&site=stackoverflow"
    // safe to force unwrap as we know this url is good
    let url = URL(string: userEndpoint)!
    let request = URLRequest(url: url)
    let response: UserFetchResponse = try await networkingService.makeRequest(request)
    return response.items
  }
  
  func fetchUserProfileImage(_ user: User) async throws -> Data {
    
    guard let profileImageUrl = user.profileImageUrl else {
      throw UserFetchServiceError.userProfileUrlFailure
    }
    
    let request = URLRequest(url: profileImageUrl)
    
    // check if image is already in cache
    if let cached = imageCache.cachedResponse(for: request) {
      // return cached image
      return cached.data
    }
    
    do {
      // make actual call
      let (data, response) = try await networkingService.makeRequest(request)
      // stash data and response in cache
      imageCache.storeCachedResponse(.init(response: response, data: data), for: request)
      return data
    }
    
  }
}
