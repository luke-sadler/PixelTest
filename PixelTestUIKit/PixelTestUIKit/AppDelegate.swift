//
//  AppDelegate.swift
//  PixelTestUIKit
//
//  Created by luke on 15/10/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    if NSClassFromString("XCTest") != nil {
      InjectedValues[\.userFetchServiceProvider] = UserFetchServiceMock()
    }
    
    return true
  }

}

