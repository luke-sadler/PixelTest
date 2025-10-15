//
//  NetworkRequesterImpl.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

class NetworkingServiceImpl: NetworkingService {
  
  func makeRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
    
    let (data, _) = try await makeRequest(request)
    return try jsonDecoder.decode(T.self, from: data)
  }
  
  func makeRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
    let (data, response) = try await URLSession.shared.data(for: request)
    
    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    
    guard statusCode == 200 else {
      throw NetworkRequestError.fetchingError(statusCode: statusCode)
    }

    return (data, response)
  }
  
}
