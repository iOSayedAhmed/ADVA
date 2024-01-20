//
//  SplachViewModelTests.swift
//  ADVATests
//
//  Created by iOSAYed on 20/01/2024.
//

import XCTest
import RxSwift
@testable import ADVA

final class SplachViewModelTests: XCTestCase {

    var viewModel: SplachViewModel!

    override func setUpWithError() throws {
        viewModel = SplachViewModel()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAnimationDidFinish() {
        let expectation = self.expectation(description: "AnimationCompleted should emit true")
        var emittedValues = [Bool]()

        let subscription = viewModel.animationCompleted.subscribe(onNext: { value in
            emittedValues.append(value)
            if value == true {
                expectation.fulfill()
            }
        })
        viewModel.animationDidFinish()

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(emittedValues.contains(true), "AnimationDidFinish should emit true")

        subscription.dispose()
    }



}
