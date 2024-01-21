//
//  AlbumsCoordinator.swift
//  ADVA
//
//  Created by iOSAYed on 21/01/2024.
//

import UIKit

final class AlbumsCoordinator:Coordinator {
    
    
    private(set) var childCoordinators: [Coordinator] = []
    
     let navigationController:UINavigationController
    
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
       
        let albumsViewModel = AlbumsViewModel(coordinator: self)
        let albumsVC = AlbumsVC(viewModel: albumsViewModel, nibName: "\(AlbumsVC.self)")
        navigationController.setViewControllers([albumsVC], animated: true)
    }
}
