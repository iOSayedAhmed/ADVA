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
    func goToMainTabBar()
    func didDisAppear()
}

final class SplachViewModel :SplachViewModelType {
   
    
   
    weak var coordinator:SplashCoordinator?
    
     init(coordinator: SplashCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    let animationCompleted: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)

    func animationDidFinish() {
        animationCompleted.onNext(true)
    }
    
    func goToMainTabBar(){
        coordinator?.startMainTabBarCoordinator()
    }
    
    func didDisAppear(){
        coordinator?.didDisAppear()
    }
    
    deinit {
        print(" SplachViewModel Deallocted")
    }
    
}
