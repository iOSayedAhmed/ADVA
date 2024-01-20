//
//  MockSplachViewModel.swift
//  ADVATests
//
//  Created by iOSAYed on 20/01/2024.
//

import XCTest
import RxSwift
@testable import ADVA

class MockSplachViewModel: SplachViewModelType {
    var animationCompleted: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    var animationDidFinishCalled = false

    func animationDidFinish() {
        animationDidFinishCalled = true
        animationCompleted.onNext(true)
    }
}
