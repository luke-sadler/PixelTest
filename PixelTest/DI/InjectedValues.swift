//
//  DependencyInjection.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation

/// This approach is heavily inspired by this article. https://www.avanderlee.com/swift/dependency-injection/
/// This is the method I've taken for custom DI for a few years now and found it scales perfectly well and helps tremendously when it comes to unit testing or otherwise mocking data sources
/// which, in this test, will be helpful when it comes to "following" users.

/// Provides access to injected dependencies.
struct InjectedValues {
  
  /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
  private static var current = InjectedValues()
  
  /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
  static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
    get { key.currentValue }
    set { key.currentValue = newValue }
  }
  
  /// A static subscript accessor for updating and references dependencies directly.
  static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
    get { current[keyPath: keyPath] }
    set { current[keyPath: keyPath] = newValue }
  }
}

extension InjectedValues {
  // MARK: - User fetching
  private struct UserFetchServiceKey: InjectionKey {
    static var currentValue: UserFetchService = UserFetchServiceImpl()
  }
  
  var userFetchServiceProvider: UserFetchService {
    get { Self[UserFetchServiceKey.self] }
    set { Self[UserFetchServiceKey.self] = newValue }
  }
  
  // MARK: - Account management
  private struct AccountManagementServiceKey: InjectionKey {
    static var currentValue: AccountManagementService = AccountManagementMock() // implicitly setting 
  }
  
  var accountManagementServiceProvider: AccountManagementService {
    get { Self[AccountManagementServiceKey.self] }
    set { Self[AccountManagementServiceKey.self] = newValue }
  }
  
}
