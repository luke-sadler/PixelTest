//
//  NetworkRequester.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

enum NetworkRequestError: Error {
  case fetchingError(statusCode: Int)
}

protocol NetworkingService {
  
  var jsonDecoder: JSONDecoder { get }
  
  func makeRequest<T: Decodable>(_ request: URLRequest) async throws -> T
  func makeRequest(_ request: URLRequest) async throws -> (Data, URLResponse)
}

extension NetworkingService {
  var jsonDecoder: JSONDecoder {
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
}
