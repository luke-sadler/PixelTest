//
//  AsyncButton.swift
//  PixelTest
//
//  Created by luke on 09/10/2025.
//

import Foundation
import SwiftUI

// An async button i've used for a good while now for gracefully handling async functions within a button tap taken from https://www.swiftbysundell.com/articles/building-an-async-swiftui-button/

/// Performs async functions on tap action.
struct AsyncButton<Label: View>: View {
  var action: () async -> Void
  @ViewBuilder var label: () -> Label
  
  @State private var isPerformingTask = false
  
  var body: some View {
    Button(
      action: {
        isPerformingTask = true
        
        Task {
          await action()
          isPerformingTask = false
        }
      },
      label: {
        ZStack {
          // We hide the label by setting its opacity
          // to zero, since we don't want the button's
          // size to change while its task is performed:
          label()
            .opacity(isPerformingTask ? 0.6 : 1)
          
          if isPerformingTask {
            ProgressView()
          }
        }
      }
    )
    .disabled(isPerformingTask)
  }
}

