//
//  MainTabBarCoordinator.swift
//  ADVA
//
//  Created by iOSAYed on 21/01/2024.
//


import UIKit

final class MainCoordinator: Coordinator {
    private(set)var childCoordinators: [Coordinator] = []
    
     let navigationController:UINavigationController
    
    // Initialize with a navigation controller
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        // Create TabBarController
        let tabBarController = MainTabBarController()
        
        // Create child coordinators for each tab
        let photosCoordinator = PhotosCoordinator(navigationController: UINavigationController())
        let albumsCoordinator = AlbumsCoordinator(navigationController: UINavigationController())
        
        // Store child coordinators
//        childCoordinators.append(photosCoordinator)
//        childCoordinators.append(albumsCoordinator)
        
        
        
        // Start child coordinators
        photosCoordinator.start()
        albumsCoordinator.start()
        
        // Set up navigation controllers for each tab
        let photosNavigationController = photosCoordinator.navigationController
        let albumsNavigationController = albumsCoordinator.navigationController
        
        photosNavigationController.title = "Photos"
        photosNavigationController.tabBarItem.selectedImage = UIImage(systemName: "photo.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        photosNavigationController.tabBarItem.image = UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        
        albumsNavigationController.title = "Albums"
        albumsNavigationController.tabBarItem.selectedImage = UIImage(systemName: "rectangle.stack.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        albumsNavigationController.tabBarItem.image = UIImage(systemName: "rectangle.stack")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        childCoordinators.append(photosCoordinator)
        childCoordinators.append(albumsCoordinator)
        tabBarController.viewControllers = [photosNavigationController,albumsNavigationController]
        // Push the tab bar controller
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    
   
}
