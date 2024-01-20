//
//  SplachViewModel.swift
//  ADVA
//
//  Created by iOSAYed on 16/01/2024.
//

import Foundation
import RxSwift


protocol SplachViewModelType {
    var animationCompleted: BehaviorSubject<Bool> { get }
    func animationDidFinish()
}

final class SplachViewModel :SplachViewModelType {
   
    
    let animationCompleted: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)

    func animationDidFinish() {
        animationCompleted.onNext(true)
    }
    
    
    
    
}
