//
//  NetworkRequesterImpl.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

class NetworkRequesterImpl: NetworkRequester {
  
  func makeRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    
    guard statusCode == 200 else {
      throw NetworkRequestError.fetchingError(statusCode: statusCode)
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return try decoder.decode(T.self, from: data)
  }
  
}
