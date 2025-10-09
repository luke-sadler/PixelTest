//
//  PixelTestApp.swift
//  PixelTest
//
//  Created by luke on 08/10/2025.
//

import SwiftUI

@main
struct PixelTestApp: App {
  
  init() {
    if NSClassFromString("XCTest") != nil {
      InjectedValues[\.userFetchServiceProvider] = UserFetchServiceMock()
    }
  }
  
  var body: some Scene {
    WindowGroup {
      UserList()
    }
  }
}
