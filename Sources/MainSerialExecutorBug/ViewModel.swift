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

  public var loadInt: ((Int) -> Void) -> Void

  func loadInt() async -> Int {
    await withCheckedContinuation { continuation in
      self.loadInt { int in
        continuation.resume(returning: int)
      }
    }
  }

  public init(
    loadInt: @escaping ((Int) -> Void) -> Void
  ) {
    self.loadInt = loadInt
    self.didTapButton = { [weak self] in
      guard let self else { return }
      Task {
        await self.doAsyncWork()
      }
    }
  }

  private func doAsyncWork() async {
    isLoading = true
    defer { isLoading = false }
    self.integer = await loadInt()
  }
}
