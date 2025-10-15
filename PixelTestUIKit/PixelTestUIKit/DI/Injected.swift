//
//  InjectedValues.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

@propertyWrapper
struct Injected<T> {
  private let keyPath: WritableKeyPath<InjectedValues, T>
  var wrappedValue: T {
    get { InjectedValues[keyPath] }
    set { InjectedValues[keyPath] = newValue }
  }
  
  init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
    self.keyPath = keyPath
  }
}

public protocol InjectionKey {
  
  /// The associated type representing the type of the dependency injection key's value.
  associatedtype Value
  
  /// The default value for the dependency injection key.
  static var currentValue: Self.Value { get set }
}
