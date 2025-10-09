//
//  NetworkRequester.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

protocol NetworkRequester {
  func makeRequest<T: Decodable>(_ request: URLRequest) async throws -> T
}
