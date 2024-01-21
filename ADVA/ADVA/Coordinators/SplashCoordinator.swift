//
//  SplashCoordinator.swift
//  ADVA
//
//  Created by iOSAYed on 21/01/2024.
//

import Foundation
import UIKit


final class SplashCoordinator:Coordinator {

    
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator:AppCoordinator?
    private let navigationController:UINavigationController
    
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
        let splashScreenViewModel = SplachViewModel(coordinator: self)
        let splashScreenVC = SplashVC(viewModel: splashScreenViewModel, nibName: "\(SplashVC.self)")
        splashScreenVC.viewModel = splashScreenViewModel
        navigationController.setViewControllers([splashScreenVC], animated: true)
    }
  
      
    func startMainTabBarCoordinator(){
        let mainTabBarCoordinator = MainCoordinator(navigationController: navigationController)
        mainTabBarCoordinator.navigationController.navigationBar.isHidden = true
        childCoordinators.append(mainTabBarCoordinator)
        mainTabBarCoordinator.start()
    }
    
    func didDisAppear(){
        parentCoordinator?.childDidFinish(self)
    }

    
    deinit {
        print(" Coordinator Deallocted")
    }

}
