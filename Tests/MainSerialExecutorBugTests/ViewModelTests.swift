//
//  ViewModelTests.swift
//  MainSerialExecutorBug
//
//  Created by Rhys Morgan on 11/09/2024.
//

import ConcurrencyExtras
import MainSerialExecutorBug
import XCTest

final class ViewModelTests: XCTestCase {
  func testLoadingState() async {
    await withMainSerialExecutor {
      let viewModel = ViewModel(
        loadInt: {
          await Task.yield()
          return 5
        }
      )

      XCTAssertFalse(viewModel.isLoading)
      XCTAssertNil(viewModel.integer)

      viewModel.didTapButton()

      await Task.yield()

      XCTAssertTrue(viewModel.isLoading)

      await Task.yield()
      /// This now seems to need a second `await Task.yield()` as of Xcode 16
//      await Task.yield()

      XCTAssertFalse(viewModel.isLoading)
      XCTAssertEqual(viewModel.integer, 5)
    }
  }
}
