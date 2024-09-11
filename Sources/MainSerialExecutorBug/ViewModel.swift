//
//  ViewModel.swift
//  MainSerialExecutorBug
//
//  Created by Rhys Morgan on 11/09/2024.
//

import Foundation

@Observable
public final class ViewModel {
  public var isLoading = false
  public var integer: Int?

  public var didTapButton: () -> Void = {}
  public var loadInt: () async -> Int

  public init(
    loadInt: @Sendable @escaping () async -> Int
  ) {
    self.loadInt = loadInt
    self.didTapButton = { [weak self] in
      Task {
        await self?.doAsyncWork()
      }
    }
  }

  private func doAsyncWork() async {
    isLoading = true
    defer { isLoading = false }
    self.integer = await loadInt()
  }
}
